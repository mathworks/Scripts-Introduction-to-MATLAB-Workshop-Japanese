
% estimate_g_from_csv.m
% CSVから重力加速度を推定するスクリプト

filename = 'ball_bouncing.csv';

% テーブルとして読み込む（ヘッダが無ければ自動でvar1,var2...になる）
T = readtable(filename);

% 列名の推定（柔軟に対応）
varNames = T.Properties.VariableNames;

% Time 列の検出
timeIdx = find(contains(lower(varNames),'time'),1);
if isempty(timeIdx)
    timeIdx = 1; % 無ければ1列目を時刻とみなす
end
time = T{:,timeIdx};

% Position 列の検出
posIdx = find(contains(lower(varNames),'position') | contains(lower(varNames),'pos'),1);
if isempty(posIdx)
    % 無ければ2列目を位置とみなす（典型的構成）
    posIdx = min(2,size(T,2));
end
pos = T{:,posIdx};

% Velocity 列（表示用・未使用でもOK）
velIdx = find(contains(lower(varNames),'velocity') | contains(lower(varNames),'vel'),1);
if ~isempty(velIdx)
    vel = T{:,velIdx};
else
    vel = [];
end

% 最初に position==0 になるインデックスを見つける（厳密一致が無ければ <=0 または符号変化）
idx_zero = find(pos==0,1);
if isempty(idx_zero)
    idx_zero = find(pos<=0,1); % 負や0に入る瞬間
end
if isempty(idx_zero)
    % 符号変化を検出（浮動誤差で厳密0が無い場合）
    sgn = sign(pos);
    d = find(diff(sgn)~=0,1);
    if ~isempty(d)
        idx_zero = d+1;
    end
end
if isempty(idx_zero)
    error('Position が 0 になる点が見つかりません。データを確認してください。');
end

% 使用区間：最初から idx_zero の 1つ前まで
useIdx = 1:(idx_zero-1);
if numel(useIdx) < 3
    error('十分なデータ点がありません（少なくとも3点必要）。');
end

t = time(useIdx);
s = pos(useIdx);

% 時刻を区間先頭にシフトすると数値安定化に有利
t0 = t(1);
t_shift = t - t0;

% デザイン行列 [1, t, t^2]
X = [ones(size(t_shift)), t_shift, t_shift.^2];

% 最小二乗推定
coeff = X \ s; % coeff = [s0; v0; 0.5*a]
s0_est = coeff(1);
v0_est = coeff(2);
a_half = coeff(3);
a_est = 2 * a_half; % 位置方程式の2乗項係数から加速度を復元

% 結果表示（符号に注意）
fprintf('推定された a = %.6g (単位は Position の単位 / time^2)\n', a_est);
fprintf('推定された初期位置 s0 = %.6g\n', s0_est);
fprintf('推定された初速度 v0 = %.6g\n', v0_est);

% プロットで確認
figure;
hold on;
plot(t, s, 'bo', 'DisplayName', 'データ（使用区間）');
t_fit = linspace(t(1), t(end), 200);
t_fit_shift = t_fit - t0;
s_fit = s0_est + v0_est * t_fit_shift + 0.5 * a_est * t_fit_shift.^2;
plot(t_fit, s_fit, 'r-', 'LineWidth', 1.5, 'DisplayName', '2次フィット');
xlabel('Time');
ylabel('Position');
legend('Location','best');
title(sprintf('Estimated a = %.4g', a_est));
grid on;
hold off;