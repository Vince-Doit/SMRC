function result = remove_kth_element(n, k)
    % 创建一个1到n的数组
    arr = 1:n;
    
    % 检查k是否在有效范围内
    if k < 1 || k > n
        error('k必须在1到n之间');
    end
    
    % 移除第k个元素
    arr(k) = [];
    
    % 返回结果
    result = arr;
end
