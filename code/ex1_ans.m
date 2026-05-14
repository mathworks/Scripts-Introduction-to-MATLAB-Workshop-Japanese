% Copyright 2026 The MathWorks, Inc.
%% 正弦波のプロット
% 0, 1, 2, …, 100の整数xを定義する
x = 0:100;

% sin(x / (2*pi)の変数yを定義する
y = sin(x / (2*pi));

% 横軸がx、縦軸がyとなるようにプロットする
plot(x, y)

%% 正弦波のプロットの色を青から赤に変えてみましょう
plot(x, y, 'r')