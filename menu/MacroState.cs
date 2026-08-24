using System.Text.Json;

namespace MacroMenu;

public class MacroState
{
    public static readonly MacroState Instance = new();

    public static readonly string StateFile =
        Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.UserProfile),
            ".hammerspoon", "macro_state.json");

    private bool _enabled;
    private bool _writing;

    public bool Enabled
    {
        get => _enabled;
        set
        {
            if (_enabled == value) return;
            _enabled = value;
            EnabledChanged?.Invoke(this, value);
            WriteState(value);
        }
    }

    public event EventHandler<bool>? EnabledChanged;

    public void SetFromFile(bool value)
    {
        if (_enabled == value) return;
        _enabled = value;
        EnabledChanged?.Invoke(this, value);
    }

    private void WriteState(bool enabled)
    {
        try
        {
            _writing = true;
            File.WriteAllText(StateFile, JsonSerializer.Serialize(new { enabled }));
        }
        catch { }
        finally { _writing = false; }
    }

    public bool IsWriting => _writing;
}
