%% 2002年から2007年の停電データの読み取り
% (1) 「エディター」タブにある「セクションを実行」をクリックします。
clc; clear; close all
fileName = "outages_data_2002to2007.csv";
opts = detectImportOptions(fileName);
opts.VariableTypes(2) = {'string'};
opts.VariableTypes(5) = {'string'};
opts.VariableTypes(7) = {'categorical'};
data = readtable(fileName, opts);

%% ヒートマップの描画
% (2) 変数名「Region」を横軸、変数名「Name」を縦軸にしたヒートマップを描きます。
% ヒント：heatmap(data, "横軸の変数名", "縦軸の変数名") と書きます。
hm = heatmap(data, "Region", "Name");

% 書き終わったら「エディター」タブにある「セクションを実行」をクリックします。

%% カラーマップの変更
% (3) カラーマップを「nebula」に変えてみます。
% ヒント：colormap("カラーマップの名前") と書きます。
% カラーマップの名前は colormaplist() で確認できます。
colormap("nebula")

% 書き終わったら「エディター」タブにある「セクションを実行」をクリックします。

%% 2008年から2013年までの停電データの読み取りと可視化
% (4) 「エディター」タブにある「セクションを実行」をクリックします。
fileName = "outages_data_2008to2013.csv";
data2 = readtable(fileName, opts);
figure;
hm2 = heatmap(data2, "Region", "Name");
colormap("nebula")

%% タブ表示と並べて表示の切り替え
% (5) Figure ウィンドウで、「レイアウト」タブをクリックし、
% 　「すべて並べて表示」をクリックします。

% (6) 2つのヒートマップのタイトル「Name と Region のカウント」をクリックして、
% 左側を「Name と Region のカウント (2002-2007年)」
% 右側を「Name と Region のカウント (2008-2013年)」
% に変更します。

%% カラーバーの調整
% (7) 「hm」と「hm2」の2つのヒートマップの色のスケールを0から150に合わせます。
% ヒント：clim(ヒートマップの変数名, [最小値 最大値]) と書きます。
clim(hm, [0 150]);
clim(hm2, [0 150]);

% 書き終わったら「エディター」タブにある「セクションを実行」をクリックします。