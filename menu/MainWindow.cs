using System.Text.Json;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Input;
using Avalonia.Layout;
using Avalonia.Media;
using Avalonia.Threading;

namespace MacroMenu;

public class MainWindow : Window
{
    private readonly TextBlock _btnText;
    private readonly TextBlock _statusText;
    private readonly Border _btnBorder;

    private static readonly IBrush BgOff     = new SolidColorBrush(Color.Parse("#1a1a1a"));
    private static readonly IBrush BgOn      = new SolidColorBrush(Color.Parse("#0d2117"));
    private static readonly IBrush BorderOff = new SolidColorBrush(Color.Parse("#333"));
    private static readonly IBrush BorderOn  = new SolidColorBrush(Color.Parse("#22c55e"));
    private static readonly IBrush TextOff   = new SolidColorBrush(Color.Parse("#555"));
    private static readonly IBrush TextOn    = new SolidColorBrush(Color.Parse("#22c55e"));
    private static readonly IBrush SubOff    = new SolidColorBrush(Color.Parse("#444"));

    public MainWindow()
    {
        Title = "Macro Control";
        Width = 260;
        Height = 300;
        CanResize = false;
        Background = new SolidColorBrush(Color.Parse("#0f0f0f"));
        WindowStartupLocation = WindowStartupLocation.CenterScreen;

        _btnText = new TextBlock
        {
            Text = "OFF",
            FontSize = 15,
            FontWeight = FontWeight.SemiBold,
            Foreground = TextOff,
            HorizontalAlignment = HorizontalAlignment.Center,
            VerticalAlignment = VerticalAlignment.Center,
        };

        _btnBorder = new Border
        {
            Width = 110,
            Height = 110,
            CornerRadius = new CornerRadius(55),
            Background = BgOff,
            BorderBrush = BorderOff,
            BorderThickness = new Thickness(2.5),
            Child = _btnText,
            Cursor = new Cursor(StandardCursorType.Hand),
        };
        _btnBorder.PointerPressed += (_, _) => MacroState.Instance.Enabled = !MacroState.Instance.Enabled;

        _statusText = new TextBlock
        {
            Text = "DISABLED",
            FontSize = 11,
            FontWeight = FontWeight.Medium,
            Foreground = SubOff,
            HorizontalAlignment = HorizontalAlignment.Center,
            LetterSpacing = 1.5,
        };

        var hint = new TextBlock
        {
            Text = "Mouse4 to toggle in-game",
            FontSize = 10,
            Foreground = new SolidColorBrush(Color.Parse("#2b2b2b")),
            HorizontalAlignment = HorizontalAlignment.Center,
        };

        var titleLabel = new TextBlock
        {
            Text = "RIFLE MACRO",
            FontSize = 11,
            FontWeight = FontWeight.Medium,
            Foreground = new SolidColorBrush(Color.Parse("#3a3a3a")),
            HorizontalAlignment = HorizontalAlignment.Center,
            LetterSpacing = 2,
        };

        Content = new StackPanel
        {
            VerticalAlignment = VerticalAlignment.Center,
            HorizontalAlignment = HorizontalAlignment.Center,
            Spacing = 18,
            Children = { titleLabel, _btnBorder, _statusText, hint }
        };

        MacroState.Instance.EnabledChanged += (_, enabled) =>
            Dispatcher.UIThread.Post(() => ApplyState(enabled));

        StartFileWatcher();
    }

    private void StartFileWatcher()
    {
        var dir = Path.GetDirectoryName(MacroState.StateFile)!;
        var file = Path.GetFileName(MacroState.StateFile);

        var watcher = new FileSystemWatcher(dir, file)
        {
            NotifyFilter = NotifyFilters.LastWrite,
            EnableRaisingEvents = true
        };

        watcher.Changed += (_, _) =>
        {
            if (MacroState.Instance.IsWriting) return;
            try
            {
                Thread.Sleep(30);
                var json = File.ReadAllText(MacroState.StateFile);
                var data = JsonSerializer.Deserialize<MacroStateDto>(json);
                if (data != null)
                    MacroState.Instance.SetFromFile(data);
            }
            catch { }
        };
    }

    private void ApplyState(bool enabled)
    {
        _btnText.Text = enabled ? "ON" : "OFF";
        _btnText.Foreground = enabled ? TextOn : TextOff;
        _btnBorder.Background = enabled ? BgOn : BgOff;
        _btnBorder.BorderBrush = enabled ? BorderOn : BorderOff;
        _statusText.Text = enabled ? "ACTIVE" : "DISABLED";
        _statusText.Foreground = enabled ? TextOn : SubOff;
    }
}
