local rifle = {}

rifle.CONFIG = {
    debug = true,
    
    sensitivity = 0.6,      
    fov = 90, 
    dpi = 1600,      
    screenResolutionHeight = 1200,
    strength = 3.0,
    maxPixelsPerTick = 4,
    injectMode = "deep",
    hidDaemonPort = 39241,
    
    basePattern = {
    {dx = 0, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 4},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 4},
    {dx = 0, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 3, delay = 4},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 1},
    {dx = 2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 4},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 37},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 4},
    {dx = -1, dy = 1, delay = 2},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 3},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 5},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = -1, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 3},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 1, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 35},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 3, delay = 3},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 3},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 1, dy = 3, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 3, delay = 2},
    {dx = 0, dy = -1, delay = 2},
    {dx = 0, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 4},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 36},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -3, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 3},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 1, dy = 2, delay = 3},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 3, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 37},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 3},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 3},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 3},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 3, delay = 3},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -3, dy = -1, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 2},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 36},
    {dx = 0, dy = 1, delay = 1},
    {dx = 3, dy = -2, delay = 2},
    {dx = -1, dy = 1, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = -1, dy = -1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -3, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 3},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 3},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 35},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 3},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 3},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 2},
    {dx = 1, dy = 0, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 4},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 3},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 34},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 3},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = -1, delay = 2},
    {dx = 0, dy = 3, delay = 1},
    {dx = -2, dy = 0, delay = 3},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 3},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 3},
    {dx = -2, dy = 2, delay = 3},
    {dx = -1, dy = 3, delay = 3},
    {dx = 0, dy = 1, delay = 4},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = -2, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 35},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 2},
    {dx = -2, dy = 1, delay = 4},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = -1, delay = 2},
    {dx = 0, dy = 3, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -3, dy = 1, delay = 1},
    {dx = 0, dy = 3, delay = 3},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = -1, delay = 1},
    {dx = 1, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 4},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 3},
    {dx = 1, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 36},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 3},
    {dx = 1, dy = 2, delay = 1},
    {dx = -3, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 0, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = -1, delay = 1},
    {dx = 1, dy = 3, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 3, delay = 2},
    {dx = 0, dy = -1, delay = 2},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 3},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 35},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = -1, delay = 2},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 3},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 2},
    {dx = 0, dy = -2, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 3},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 3},
    {dx = -2, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 3},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -3, dy = 3, delay = 3},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 36},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 2},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 3, delay = 4},
    {dx = -2, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 4},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = 3, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = -3, dy = 3, delay = 2},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 3},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 2},
    {dx = 0, dy = 3, delay = 1},
    {dx = -2, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 35},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = -1, dy = -1, delay = 2},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 3},
    {dx = 1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 3},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = -1, delay = 1},
    {dx = 1, dy = 3, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 34},
    {dx = 0, dy = 3, delay = 1},
    {dx = -1, dy = 0, delay = 3},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 3},
    {dx = -2, dy = 2, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 3},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 3, delay = 3},
    {dx = -1, dy = -1, delay = 2},
    {dx = 0, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 3},
    {dx = 1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 34},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = -2, dy = -2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -3, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 3, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 0, delay = 2},
    {dx = -2, dy = 3, delay = 2},
    {dx = -1, dy = 0, delay = 2},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = -3, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 2},
    {dx = 0, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 35},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = -2, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 2},
    {dx = -1, dy = -1, delay = 1},
    {dx = -2, dy = 3, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 2},
    {dx = -3, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 4},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 36},
    {dx = -1, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 4},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 3},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 4},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 3},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 38},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 3},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = -3, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = -2, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 3},
    {dx = 1, dy = 1, delay = 1},
    {dx = -3, dy = -1, delay = 2},
    {dx = -1, dy = -1, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -3, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 2},
    {dx = -1, dy = 0, delay = 3},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 3},
    {dx = -2, dy = 0, delay = 3},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -3, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = 2, dy = 1, delay = 1},
    {dx = -3, dy = 2, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 1, delay = 37},
    {dx = -1, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 2},
    {dx = 2, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 3},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 4},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 3, delay = 3},
    {dx = -1, dy = 2, delay = 2},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 1, dy = 2, delay = 38},
    {dx = -3, dy = -1, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 3},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 3},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 4},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 3},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 3},
    {dx = -1, dy = 2, delay = 2},
    {dx = 1, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 5},
    {dx = -2, dy = 2, delay = 3},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 34},
    {dx = -1, dy = 2, delay = 2},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -3, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 2},
    {dx = 1, dy = -1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 3, delay = 3},
    {dx = -2, dy = -1, delay = 2},
    {dx = 0, dy = 3, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -3, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 4},
    {dx = -1, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 3},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 3},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 4},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 35},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 3, delay = 1},
    {dx = -3, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 3},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -3, dy = 0, delay = 1},
    {dx = 1, dy = 3, delay = 2},
    {dx = -1, dy = -1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 3},
    {dx = 0, dy = 3, delay = 1},
    {dx = -2, dy = -1, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 3},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 33},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 3, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 4},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 3, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = -1, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 36},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 1},
    {dx = -1, dy = 3, delay = 3},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 2},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 3},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 3},
    {dx = -2, dy = 2, delay = 3},
    {dx = -1, dy = 0, delay = 2},
    {dx = 1, dy = 3, delay = 1},
    {dx = -3, dy = -1, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 3},
    {dx = -2, dy = 1, delay = 36},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 3},
    {dx = -2, dy = 0, delay = 2},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 2, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -3, dy = 0, delay = 1},
    {dx = 1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 1, delay = 4},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = -1, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = -3, dy = 2, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 3},
    {dx = 0, dy = 3, delay = 1},
    {dx = 0, dy = -1, delay = 2},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 3, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = -2, dy = 1, delay = 4},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 2},
    {dx = 0, dy = 1, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 3},
    {dx = -1, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 2},
    {dx = -2, dy = 0, delay = 3},
    {dx = 0, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = -1, delay = 1},
    {dx = -2, dy = 3, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 35},
    {dx = 1, dy = 0, delay = 1},
    {dx = -3, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 2, delay = 1},
    {dx = -1, dy = 0, delay = 2},
    {dx = 0, dy = 3, delay = 1},
    {dx = -2, dy = 1, delay = 4},
    {dx = -1, dy = 3, delay = 3},
    {dx = 0, dy = -1, delay = 1},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 3},
    {dx = -2, dy = 1, delay = 1},
    {dx = 1, dy = 0, delay = 2},
    {dx = -2, dy = 2, delay = 1},
    {dx = 0, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 1, dy = 0, delay = 1},
    {dx = -1, dy = 3, delay = 1},
    {dx = 1, dy = -1, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -2, dy = 1, delay = 2},
    {dx = 0, dy = 2, delay = 3},
    {dx = -1, dy = 1, delay = 3},
    {dx = -2, dy = 2, delay = 3},
    {dx = 0, dy = 1, delay = 1},
    {dx = -1, dy = 2, delay = 3},
    {dx = -2, dy = 1, delay = 2},
    {dx = 1, dy = 2, delay = 2},
    {dx = 2, dy = 0, delay = 1},
    {dx = -1, dy = 1, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 0, delay = 2},
    {dx = -2, dy = 0, delay = 1},
    {dx = 0, dy = 2, delay = 2},
    {dx = -1, dy = 1, delay = 1},
    {dx = -2, dy = 2, delay = 3},
    {dx = -1, dy = 1, delay = 2}
    },
    
    activationSequence = {
        --[[ {dx = 1,  dy = 0}, 
        {dx = 0,  dy = 1}, 
        {dx = -1, dy = 0}, 
        {dx = 0,  dy = -1} ]]
    },
    
    calibrationSequence = {
        --[[ {dx = 0,  dy = 0,  delay = 20},   
        {dx = 1,  dy = 0,  delay = 20},   
        {dx = -1, dy = 0,  delay = 20},   
        {dx = 0,  dy = 1,  delay = 20},   
        {dx = 0,  dy = -1, delay = 20},   
        {dx = 0,  dy = 0,  delay = 20}  ]]
    }
}

rifle.STATE = {
    enabled = false,   
    shooting = false,    
    stepIndex = 1,      
    patternLength = 30,  
    currentPattern = {},  
    originalMousePosition = nil,
    compensationTimer = nil,
    isInGameMode = false,
    rawInputActivated = false,
    activationTimer = nil,
    activationCounter = 0,
    currentMethod = 1,
    calibrationStep = 1,
    patternTimeMs = 0,
    compStartedAt = 0,
    accumDx = 0,
    accumDy = 0,
    owedDx = 0,
    owedDy = 0,
    lastRealMouseAt = 0,
    deepTap = nil,
    hidSock = nil,
    hidAvailable = false,
    injecting = false
}

local function isRustActive()
    local app = hs.application.frontmostApplication()
    return app and (app:name() == "Rust" or string.find(app:name() or "", "RustClient"))
end

function rifle:log(msg)
    if self.CONFIG.debug and isRustActive() then
        print("[Rifle] " .. msg)
    end
end

function rifle:hidConnected()
    local sock = self.STATE.hidSock
    if not sock then return false end
    local ok, connected = pcall(function() return sock:connected() end)
    return ok and connected
end

function rifle:hidConnect()
    if self:hidConnected() then
        self.STATE.hidAvailable = true
        return true
    end

    local port = self.CONFIG.hidDaemonPort or 39241
    if self.STATE.hidSock then
        pcall(function() self.STATE.hidSock:disconnect() end)
        self.STATE.hidSock = nil
    end

    local sock = hs.socket.new()
    sock:connect("127.0.0.1", port)
    for _ = 1, 10 do
        hs.timer.usleep(5000)
        local ok, connected = pcall(function() return sock:connected() end)
        if ok and connected then
            self.STATE.hidSock = sock
            self.STATE.hidAvailable = true
            return true
        end
    end
    self.STATE.hidAvailable = false
    return false
end

function rifle:hidSend(dx, dy)
    if not self:hidConnected() then
        return false
    end
    local ok = pcall(function()
        self.STATE.hidSock:write(string.format("m %d %d\n", dx, dy))
    end)
    if not ok then
        self.STATE.hidAvailable = false
        pcall(function() self.STATE.hidSock:disconnect() end)
        self.STATE.hidSock = nil
        return false
    end
    return true
end

function rifle:ensureHidDaemon()
    self.STATE.hidAvailable = false
    local port = self.CONFIG.hidDaemonPort or 39241
    local bin = os.getenv("HOME") .. "/.hammerspoon/hidmouse/hid_mouse_daemon"
    if not hs.fs.attributes(bin) then
        print("[Rifle] No hid_mouse_daemon — run hidmouse/build.sh")
        return false
    end

    local function ping()
        local out = hs.execute(string.format("echo ping | nc -w 1 127.0.0.1 %d", port)) or ""
        return out:find("pong", 1, true) ~= nil
    end

    if not ping() then
        hs.execute("pkill -f 'hidmouse/hid_mouse_daemon' 2>/dev/null")
        hs.timer.usleep(100000)
        hs.task.new(bin, function(code)
            print("[Rifle] hid_mouse_daemon exited code=" .. tostring(code))
        end):start()
        hs.timer.usleep(450000)
    end

    if ping() and self:hidConnect() then
        print("[Rifle] IOHIDPostEvent injector ready — idle spray (no mouse move needed)")
        return true
    end

    print("[Rifle] IOHID injector failed — run as login user; check Accessibility")
    return false
end

function rifle:postSynthDelta(moveDx, moveDy)
    if moveDx == 0 and moveDy == 0 then return end

    if self.STATE.hidAvailable and self:hidSend(moveDx, moveDy) then
        return
    end

    local props = hs.eventtap.event.properties
    local pos = hs.mouse.absolutePosition()
    local dest = { x = pos.x + moveDx, y = pos.y + moveDy }

    self.STATE.injecting = true
    local event = hs.eventtap.event.newEvent()
    event:setType(hs.eventtap.event.types.leftMouseDragged)
    event:location(dest)
    event:setFlags({})
    event:setProperty(props.mouseEventDeltaX or 4, moveDx)
    event:setProperty(props.mouseEventDeltaY or 5, moveDy)
    event:setProperty(props.eventUnacceleratedPointerMovementX or 170, moveDx)
    event:setProperty(props.eventUnacceleratedPointerMovementY or 171, moveDy)
    event:setProperty(props.eventSourceStateID or 45, 1)
    event:post()
    self.STATE.injecting = false
end

function rifle:takeOwed(maxPixels)
    local ox, oy = self.STATE.owedDx or 0, self.STATE.owedDy or 0
    if ox == 0 and oy == 0 then return 0, 0 end

    local mag = math.max(math.abs(ox), math.abs(oy))
    if mag <= maxPixels then
        local ix = ox >= 0 and math.floor(ox + 1e-9) or math.ceil(ox - 1e-9)
        local iy = oy >= 0 and math.floor(oy + 1e-9) or math.ceil(oy - 1e-9)
        self.STATE.owedDx = ox - ix
        self.STATE.owedDy = oy - iy
        return ix, iy
    end

    local scale = maxPixels / mag
    local ix = ox >= 0 and math.floor(ox * scale + 1e-9) or math.ceil(ox * scale - 1e-9)
    local iy = oy >= 0 and math.floor(oy * scale + 1e-9) or math.ceil(oy * scale - 1e-9)
    if ix == 0 and iy == 0 then
        ix = ox > 0 and 1 or (ox < 0 and -1 or 0)
        iy = oy > 0 and 1 or (oy < 0 and -1 or 0)
    end
    self.STATE.owedDx = ox - ix
    self.STATE.owedDy = oy - iy
    return ix, iy
end

function rifle:startDeepTap()

end

function rifle:stopDeepTap()
    if self.STATE.deepTap then
        self.STATE.deepTap:stop()
        self.STATE.deepTap = nil
    end
end

function rifle:standardMouseMove(dx, dy)
    self.STATE.owedDx = (self.STATE.owedDx or 0) + (tonumber(dx) or 0)
    self.STATE.owedDy = (self.STATE.owedDy or 0) + (tonumber(dy) or 0)
end

function rifle:flushOwedSynthetic()
    local maxPix = tonumber(self.CONFIG.maxPixelsPerTick) or 4
    local ix, iy = self:takeOwed(maxPix)
    if ix == 0 and iy == 0 then return end
    self:postSynthDelta(ix, iy)
end

function rifle:stopAugmentTap()
    self:stopDeepTap()
end

function rifle:performCalibration()
    if not self.STATE.originalMousePosition then return end
    if #self.CONFIG.calibrationSequence == 0 then
        return
    end

    self:log("[CALIBRATION] Standard calibration started")

    local startPos = self.STATE.originalMousePosition

    for i, calib in ipairs(self.CONFIG.calibrationSequence) do
        if not self.STATE.shooting then break end

        self.STATE.calibrationStep = i

        hs.mouse.absolutePosition({
            x = startPos.x + calib.dx,
            y = startPos.y + calib.dy
        })

        hs.timer.usleep((calib.delay or 1) * 1000)

        hs.mouse.absolutePosition(startPos)

        if self.CONFIG.debug then
            self:log(string.format("[CALIB] Step %d/%d: dx=%d, dy=%d",
                i, #self.CONFIG.calibrationSequence, calib.dx, calib.dy))
        end
    end

    self.STATE.calibrationStep = 1
end

function rifle:stopActivationTimer()
    if self.STATE.activationTimer then
        self.STATE.activationTimer:stop()
        self.STATE.activationTimer = nil
    end
    self.STATE.rawInputActivated = false
    self.STATE.activationCounter = 0
end

function rifle:calculatePattern()
    local multiplier = tonumber(self.CONFIG.strength) or 1.0

    self:log(string.format("[CALC] strength=%.3f", multiplier))

    local scaledPattern = {}

    for i, step in ipairs(self.CONFIG.basePattern) do
        local scaledStep = {
            dx = step.dx * multiplier,
            dy = step.dy * multiplier,
            delay = step.delay
        }
        table.insert(scaledPattern, scaledStep)

        if self.CONFIG.debug and i <= 5 then
            self:log(string.format("[PATTERN] Step %d: dx=%.3f->%.3f, dy=%.3f->%.3f",
                i, step.dx, scaledStep.dx, step.dy, scaledStep.dy))
        end
    end

    return scaledPattern
end

function rifle:init()
    print("[Rifle] Initializing deep-inject RifleMacros...")

    self.STATE.currentPattern = self:calculatePattern()
    self.STATE.patternLength = #self.STATE.currentPattern

    self:ensureHidDaemon()
    self:setupHotkeys()
    self:setupMouseDetection()

    if self.STATE.hidKeepalive then
        self.STATE.hidKeepalive:stop()
    end
    self.STATE.hidKeepalive = hs.timer.new(5, function()
        if not self:hidConnected() then
            self:hidConnect()
        end
    end)
    self.STATE.hidKeepalive:start()

    print("[Rifle] Ready. Ctrl+F1 - toggle, Left Click in Rust - activation.")
    print(string.format("[Rifle] strength=%.2f | mode=%s | hid=%s",
        tonumber(self.CONFIG.strength) or 1,
        self.CONFIG.injectMode or "deep",
        tostring(self.STATE.hidAvailable)))
    hs.alert.show("RifleMacros deep-inject ready", 1)
end

function rifle:setupHotkeys()
    hs.hotkey.bind({"ctrl"}, "f1", function()
        self:toggleSystem()
    end)
end

function rifle:detectGameMode()
    local rustApp = hs.application.get("Rust") or hs.application.get("RustClient")
    if rustApp then
        local mainWindow = rustApp:mainWindow()
        if mainWindow then
            self.STATE.isInGameMode = mainWindow:isFullScreen()
            if self.CONFIG.debug then
                self:log(string.format("[MODE] Fullscreen mode: %s", 
                    tostring(self.STATE.isInGameMode)))
            end
        end
    else
        self.STATE.isInGameMode = false
    end
end

function rifle:resetState()
    self.STATE.stepIndex = 1
    self.STATE.currentMethod = 1
    self.STATE.calibrationStep = 1
    self:stopActivationTimer()
end

function rifle:toggleSystem()
    self.STATE.enabled = not self.STATE.enabled
    local status = self.STATE.enabled and "ON" or "OFF"
    print("[Rifle] System: " .. status)
    hs.alert.show("Macros: " .. status, 1)

    local stateFile = os.getenv("HOME") .. "/.hammerspoon/macro_state.json"
    local f = io.open(stateFile, "w")
    if f then
        f:write('{"enabled":' .. tostring(self.STATE.enabled) .. '}')
        f:close()
    end

    if not self.STATE.enabled then
        self:stopShooting()
        self:resetState()
    end
end

function rifle:setupMouseDetection()
    if self.mouseEventWatcher then
        self.mouseEventWatcher:stop()
    end
    
    self.mouseEventWatcher = hs.eventtap.new(
        { hs.eventtap.event.types.leftMouseDown, 
          hs.eventtap.event.types.leftMouseUp },
        function(event)
            if not self.STATE.enabled then return false end
            if not isRustActive() then return false end
            
            local eventType = event:getType()
            
            if eventType == hs.eventtap.event.types.leftMouseDown then
                if not self.STATE.shooting then
                    self.STATE.originalMousePosition = hs.mouse.absolutePosition()
                    self:resetState()
                    self:startShooting()
                    hs.timer.doAfter(0, function()
                        self:detectGameMode()
                        self:log(string.format("[START] Pos: %.0f,%.0f | Mode: %s | hid=%s",
                            self.STATE.originalMousePosition.x, self.STATE.originalMousePosition.y,
                            self.STATE.isInGameMode and "Game" or "Menu",
                            tostring(self:hidConnected())))
                    end)
                end
                
            elseif eventType == hs.eventtap.event.types.leftMouseUp then
                if self.STATE.shooting then
                    self:log("Left mouse button released - stop")
                    self:stopShooting()
                end
            end
            
            return false
        end
    )
    
    self.mouseEventWatcher:start()
    self:log("Mouse detection enabled")
end

function rifle:startShooting()
    if not self.STATE.enabled or self.STATE.shooting or not isRustActive() then
        return
    end

    self.STATE.shooting = true
    self.STATE.stepIndex = 1
    self.STATE.currentMethod = 1
    self.STATE.patternTimeMs = 0
    self.STATE.owedDx = 0
    self.STATE.owedDy = 0
    self.STATE.lastRealMouseAt = 0
    self.STATE.compStartedAt = hs.timer.secondsSinceEpoch()

    self:log("=== SHOOTING STARTED ===")
    self:log(string.format("Pattern %d steps | IOHIDPostEvent | hid=%s | strength=%.2f",
        self.STATE.patternLength, tostring(self:hidConnected()), tonumber(self.CONFIG.strength) or 1))

    self:performCalibration()
    self:startCompensationLoop()

    if not self:hidConnected() then
        hs.timer.doAfter(0, function()
            if self.STATE.shooting then
                if not self.STATE.hidAvailable then
                    self:ensureHidDaemon()
                else
                    self:hidConnect()
                end
            end
        end)
    end
end

function rifle:startCompensationLoop()
    if self.compensationTimer then
        self.compensationTimer:stop()
        self.compensationTimer = nil
    end

    self.compensationTimer = hs.timer.new(0.001, function()
        self:compensationTick()
    end)
    self.compensationTimer:start()
    self:compensationTick()
end

function rifle:compensationTick()
    if not self.STATE.shooting then
        return
    end

    if not isRustActive() then
        self:stopShooting()
        return
    end

    local wallMs = (hs.timer.secondsSinceEpoch() - self.STATE.compStartedAt) * 1000

    local accrued = 0
    while self.STATE.shooting and self.STATE.patternTimeMs <= wallMs and accrued < 3 do
        local step = self.STATE.currentPattern[self.STATE.stepIndex]
        if not step then
            self.STATE.stepIndex = 1
            step = self.STATE.currentPattern[1]
        end
        if not step then break end

        self:standardMouseMove(step.dx, step.dy)
        self.STATE.patternTimeMs = self.STATE.patternTimeMs + math.max(tonumber(step.delay) or 1, 1)
        self.STATE.stepIndex = self.STATE.stepIndex + 1
        accrued = accrued + 1

        if self.STATE.stepIndex > self.STATE.patternLength then
            self.STATE.stepIndex = 1
            self:log("[COMP] Pattern completed, starting over")
        end
    end

    self:flushOwedSynthetic()
end

function rifle:stopShooting()
    if not self.STATE.shooting then
        return
    end

    self.STATE.shooting = false
    self.STATE.patternTimeMs = 0
    self.STATE.owedDx = 0
    self.STATE.owedDy = 0

    if self.compensationTimer then
        self.compensationTimer:stop()
        self.compensationTimer = nil
    end

    self:stopDeepTap()
    self:stopActivationTimer()

    self:log("=== SHOOTING STOPPED ===")
    self:log(string.format("Steps completed: %d", math.max(self.STATE.stepIndex - 1, 0)))

    self:resetState()
end

return rifle