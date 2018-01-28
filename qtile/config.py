from libqtile.config import Key, Screen, Group
from libqtile.command import lazy
from libqtile import layout, bar, widget
from libqtile import hook
from libqtile.config import Click, Drag

mod = "mod1"

keys = [
    # Switch between windows in current stack pane
    Key(
        [mod], "k",
        lazy.layout.down()
    ),
    Key(
        [mod], "j",
        lazy.layout.up()
    ),

    # Move windows up or down in current stack
    Key(
        [mod, "shift"], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        [mod, "shift"], "j",
        lazy.layout.shuffle_up()
    ),

    # Switch window focus to other pane(s) of stack
    Key(
        [mod], "h",
        lazy.layout.next()
    ),

    # Swap panes of split stack
    Key(
        [mod], "l",
        lazy.layout.rotate()
    ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"], "h",
        lazy.layout.toggle_split()
    ),
    Key([mod], "f", lazy.window.disable_floating()),
    Key([mod, "shift"], "Return", lazy.window.enable_floating()),

    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout()),
    Key([mod], "c", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    #Key([mod], "x", lazy.spawncmd()),
]

n_groups = 9

groups = []
for g in range(1, n_groups+1):
    groups.append(Group(str(g)))

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    )

keys.append(Key([mod, "control"], "Right", lazy.screen.next_group()))
keys.append(Key([mod, "control"], "Left", lazy.screen.prev_group()))
keys.append(Key([mod], "o", lazy.next_screen()))


dgroups_key_binder = None
dgroups_app_rules = []

layouts = [
    layout.Floating(border_width=5),
    layout.Max(),
    layout.TreeTab(),
    layout.Stack(num_stacks=2)
]

widget_defaults = dict(
    font='Arial',
    fontsize=16,
    padding=3,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                #widget.TextBox("default config", name="default"),
		widget.CurrentLayout(),
                widget.Systray(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
            ],
            30,
        ),
    ),
]

main = None
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating()
mouse = [
	Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
	Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
	Click([mod], "Button1", lazy.window.bring_to_front())
]
auto_fullscreen = True
wmname = "LG3D"

@hook.subscribe.client_new
def dialogs(window):
	if(window.window.get_wm_type() == 'dialog' or window.window.get_wm_transient_for()):
		window.floating = True
