% Copyright 2026 The MathWorks, Inc.
function ex2Func(filePath)
    %% データの読み取り
    data = readtable(filePath);
    
    %% プロット
    % 時間と位置のプロット 
    plot(data, 'Time', 'Position')
    
    % 座標軸をホールドして重ね描きする
    hold on
    
    % 時間と速さのプロット 
    plot(data, 'Time', 'Velocity')
    
    hold off
    
    % 凡例表示
    legend({'位置', '速さ'})
end