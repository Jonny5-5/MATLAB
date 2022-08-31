% Use the following values:
% r for resistance
% L for inductance
% c for capacitance

ir = input("Resistance = ", 's');
iL = input("L Inductance = ", 's');
ic = input("Capacitance = ", 's');
iX0 = input("X0 = ",'s');
iX1 = input("X1 (note: this is probably Vo/L or i/c ) = ",'s');
iXf = input("Xf (final value of X) = ",'s');


r = str2num(ir);
L = str2num(iL);
c = str2num(ic);
X0 = str2num(iX0);
X1 = str2num(iX1);
Xf = str2num(iXf);

a = 1/(2*r*c);
w = 1/(sqrt(L*c));
s1 = -a + sqrt(a^2-w^2);
s2 = -a - sqrt(a^2-w^2);

syms X(t);
dX = diff(X);
dX2 = diff(X,2);
%This is the underdamped response with imaginary numbers.
X(t) = dsolve(dX2 + 1/(r*c)* dX + 1/(L*c) * X == 0, X(0) + Xf == X0, dX(0) == X1);
X(t) = X(t) + Xf;

%X = dsolve(dX2 + 1/(r*c)* dX + 1/(L*c) * X == 0, X(0) == X0, dX(0) == X1);
%Solutions in an array
%syms c1 c2;
%stuff = solve(X0 == c1 + c2, X1 == s1*c1 + s2*c2);
%X = struct2cell(stuff);
%c1 = X[1];
%c2 = X[2];

output1 = "a = " + a;
output2 = "w = " + w;
output3 = "s1 = " + s1;
output4 = "s2 = " + s2;
%output5 = "X = " + str2sym(X);
output5 = simplify(X);

fprintf('%s\n', output1);
fprintf('%s\n', output2);
fprintf('%s\n', output3);
fprintf('%s\n', output4);
display(X);
x0 = X(0);
limX = limit(X(t),inf);
fprintf("To check your work: X(0) = %s and X(inf) = %s\n", x0, limX);
