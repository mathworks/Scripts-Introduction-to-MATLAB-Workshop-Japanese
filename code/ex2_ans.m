%% データの読み取り
% (1) readtable関数を使ってファイル「ball_bouncing.csv」を読み取ってみましょう。
% 読み取るデータは変数「data」に格納します。
data = readtable("ball_bouncing.csv");

% 書き終わったら「エディター」タブにある「セクションを実行」をクリックします。

%% データの確認
% (2) ワークスペースの名前「data」をダブルクリックして、中身を確認してみましょう。

%% プロット
% (3) dataテーブルの時間「Time」列と位置「Position」列をプロットしましょう。
% ヒント：テーブルデータ「data」の「col1」列と「col2」列をプロットするには
% plot(data, 'col1', 'col2') と書きます。
plot(data, 'Time', 'Position')

%% プロットの重ね描き 
% (4) 座標軸をホールドして、
% 時間「Time」列と速さ「Velocity」列のプロットを重ね描きします。
% ヒント1：座標軸をホールドするにはhold onと書きます。
% ヒント2：テーブルデータ「data」の「col1」列と「col2」列をプロットするには
% plot(data, 'col1', 'col2') と書きます。
hold on
plot(data, 'Time', 'Velocity')

%% ホールドの解除
% (5) 座標軸のホールドを解除します。
% ヒント：座標軸のホールドを解除するにはhold offと書きます。
hold off

%% 凡例表示
% (6) Figure に凡例「位置」と「速さ」を付けます。
% ヒント：凡例を1つ付けるにはlegend('xxx')、
% 　2つ付けるにはlegend({'xxx', 'yyy'})とします
legend({'位置', '速さ'})
