slate.config('defaultToCurrentScreen', false);
var resize = (x, y) => slate.operation("resize", {
    "width": x,
    "height": y
});
var nudge = (x, y) => slate.operation("nudge", {
    "x": x,
    "y": y
});
var move = (x, y, w, h) => slate.operation("move", {
    "x": x,
    "y": y,
    "width": w,
    "height": h
});
var bindings = {
    "l": resize('+10%', '+0'),
    "h": resize('-10%', '+0'),
    "j": resize('+0', '+10%'),
    "k": resize('+0', '-10%'),
    "right": nudge('+10%', '+0'),
    "left": nudge('-10%', '+0'),
    "down": nudge('+0', '+10%'),
    "up": nudge('+0', '-10%')
};
Object.keys(bindings).forEach(binding=> {
    if (bindings[binding]) {
        slate.bind(`${binding}:cmd;esc`, bindings[binding]);
        slate.bind(`${binding}:ctrl;esc:toggle`, bindings[binding]);
    }
});
[ox,oy,sx,sy] = ["screenOriginX", "screenOriginY", "screenSizeX", "screenSizeY"];
slate.bindAll({
    "f:cmd;esc": move(ox, oy, sx, sy),
    "v:cmd;esc": move(ox, oy, `${sx}/2`, sy),
    "v:ctrl;esc": move(`${sx}/2`, oy, `${sx}/2`, sy),
    "s:cmd;esc": move(ox, oy, sx, `${sy}/2`),
    "s:ctrl;esc": move(ox, `${sy}/2`, sx, `${sy}/2`),
    "tab:alt": slate.operation("switch")
});

