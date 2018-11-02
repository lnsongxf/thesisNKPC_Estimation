% Make the plot
a = area( randn(1, 100) );
% Add a slider
uicontrol( ...
    'Style', 'slider', ...
    'Min', -3, ...
    'Max',  3, ...
    'Callback', @(src, evt) set(a, 'BaseValue', get(src, 'Value')));