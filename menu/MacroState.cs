using System.Text.Json;
using System.Text.Json.Serialization;

namespace MacroMenu;

public class MacroStateDto
{
    [JsonPropertyName("enabled")]
    public bool Enabled { get; set; }

    [JsonPropertyName("weapon")]
    public string? Weapon { get; set; }

    [JsonPropertyName("strength")]
    public double? Strength { get; set; }

    [JsonPropertyName("profile")]
    public string? Profile { get; set; }

    [JsonPropertyName("modifiers")]
    public ModifiersDto? Modifiers { get; set; }
}

public class ModifiersDto
{
    [JsonPropertyName("posture")]
    public string? Posture { get; set; }

    [JsonPropertyName("ads")]
    public bool? Ads { get; set; }

    [JsonPropertyName("moving")]
    public bool? Moving { get; set; }

    [JsonPropertyName("scope")]
    public string? Scope { get; set; }

    [JsonPropertyName("barrel")]
    public string? Barrel { get; set; }
}

public class MacroState
{
    public static readonly MacroState Instance = new();

    public static readonly string StateFile =
        Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.UserProfile),
            ".hammerspoon", "macro_state.json");

    private static readonly JsonSerializerOptions JsonOpts = new()
    {
        WriteIndented = false,
        DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
    };

    private bool _enabled;
    private string _weapon = "ak47";
    private double _strength = 3;
    private string _profile = "default";
    private ModifiersDto? _modifiers;
    private bool _writing;

    public bool Enabled
    {
        get => _enabled;
        set
        {
            if (_enabled == value) return;
            _enabled = value;
            EnabledChanged?.Invoke(this, value);
            WriteState();
        }
    }

    public string Weapon
    {
        get => _weapon;
        set
        {
            if (_weapon == value) return;
            _weapon = value;
            WriteState();
        }
    }

    public double Strength
    {
        get => _strength;
        set
        {
            if (Math.Abs(_strength - value) < 0.0001) return;
            _strength = value;
            WriteState();
        }
    }

    public string Profile => _profile;

    public event EventHandler<bool>? EnabledChanged;

    // Called from FileSystemWatcher — skips writing back to avoid loop
    public void SetFromFile(MacroStateDto data)
    {
        if (data.Weapon != null) _weapon = data.Weapon;
        if (data.Strength != null) _strength = data.Strength.Value;
        if (data.Profile != null) _profile = data.Profile;
        if (data.Modifiers != null) _modifiers = data.Modifiers;

        if (_enabled == data.Enabled) return;
        _enabled = data.Enabled;
        EnabledChanged?.Invoke(this, data.Enabled);
    }

    private void WriteState()
    {
        try
        {
            _writing = true;
            var dto = new MacroStateDto
            {
                Enabled = _enabled,
                Weapon = _weapon,
                Strength = _strength,
                Profile = _profile,
                Modifiers = _modifiers,
            };
            File.WriteAllText(StateFile, JsonSerializer.Serialize(dto, JsonOpts));
        }
        catch { }
        finally { _writing = false; }
    }

    public bool IsWriting => _writing;
}
