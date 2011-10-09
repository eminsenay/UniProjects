P = [
    0 0 1/3 0 1/2 0 1/2
    1/3 0 0 0 0 0 0 
    1/3 1/3 0 0 0 1/2 0
    0 1/3 1/3 0 0 0 0 
    0 1/3 0 1 0 0 0
    0 0 0 0 0 0 0
    1/3 0 1/3 0 1/2 1/2 1/2
    ];
S = [
    1/7 1/7 1/7 1/7 1/7 1/7 1/7
    1/7 1/7 1/7 1/7 1/7 1/7 1/7
    1/7 1/7 1/7 1/7 1/7 1/7 1/7
    1/7 1/7 1/7 1/7 1/7 1/7 1/7
    1/7 1/7 1/7 1/7 1/7 1/7 1/7
    1/7 1/7 1/7 1/7 1/7 1/7 1/7
    1/7 1/7 1/7 1/7 1/7 1/7 1/7
    ];
a = 0.5;
P1 = a * P + (1 - a) * S
r_after = [1;1;1;1;1;1;1];
r_before = [1;1;1;1;1;1;1];
%r_before = [0;0;0;0;0;0;0];
% counter = 1;
% while r_before ~= r_after
%     r_before = r_after
%     r_after = P1 * r_before
%     counter = counter + 1
% end
for i = 1:100
    r_after = P1 * r_before
    i
    if (r_after == r_before)
        break;
    end
    r_before = r_after;
end
display(r_after);