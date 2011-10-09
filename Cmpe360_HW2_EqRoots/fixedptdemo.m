func1 = [-1,1,3];
func2 = [-1/3,1,1];
func3_1 = [1,0,3];
func3_2 = [2,0];
deriv1 = polyder(func1);
deriv2 = polyder(func2);
[deriv3_quo,deriv3_div] = polyder(func3_1,func3_2);

%check the convergence of the functions
value1 = abs(polyval(deriv1,sqrt(3)));
value2 = abs(polyval(deriv2,sqrt(3)));
value3 = abs(polyval(deriv3_quo/deriv3_div,sqrt(3)));
value4 = abs(polyval(deriv1,-sqrt(3)));
value5 = abs(polyval(deriv2,-sqrt(3)));
value6 = abs(polyval(deriv3_quo/deriv3_div,-sqrt(3)));

[plus_res1,plus_res2,plus_res3] = fixedpoint(1,0.0001);
[minus_res1,minus_res2,minus_res3] = fixedpoint(-2,0.0001);
