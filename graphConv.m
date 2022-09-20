

%   graphConv
%
%   build continuous-time signals for calling graphicalConvolution function
%   
%   x:      A sampled vector of a finite length signal x(t)
%   t_x:    Vector of time values for each sample of x(t)
%   g:      A sampled vector of a finite length signal g(t)
%   t_g:    Vector of time values for each sample of g(t)
%           Note that t_x and t_g must have the same uniform sample spacing
%           of delta_t
%   manual_shift:  If true the plot progression is advanced by entering a
%           series of keyboard carriage returns, else it runs automatically
%   c:      Finite-lenth convolution output vector for c(t) = x(t)*g(t)
%   t_c:    Vector of time values for each sample of c(t)
%
%   Brian D. Jeffs, 9/15/2022

Response = input('Plot convoluiton progress manually by entering carriage returns? (y/n): ','s');
if Response == 'y'
    manual_shift = true;
    disp('Hit carriage return repeatedly to advance the convolution')
else
    manual_shift = false;
end
delta_t = .01;

% Example 1, symmetric rect window with causal exponential decay
t_x = [-1:delta_t:1];
x = ones(size(t_x));

t_g = [0:delta_t:3];
g = 2*sin(1*pi*t_g);

[t_c, c] = graphicalConvolution(x, t_x, g, t_g, manual_shift);

pause

% Example 2, two rect windows
t_x = [-1:delta_t:1];
x = ones(size(t_x));

t_g = [0:delta_t:3];
g = 0.5*ones(size(t_g));

[t_c, c] = graphicalConvolution(x, t_x, g, t_g, manual_shift);

pause

% Example 3, bipolar ramp and rect
t_x = [-1:delta_t:1];
x = t_x;

t_g = [1:delta_t:3];
g = ones(size(t_g));

[t_c, c] = graphicalConvolution(x, t_x, g, t_g, manual_shift);


