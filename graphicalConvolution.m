function [t_c, c] = graphicalConvolution(x, t_x, g, t_g, manual_shift)
%   This function plots a progressing continuous- time 
%   graphical convolution for c(t) = x(t)*g(t)
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

%  Check for matching sample intervals in x and g
delta_t = t_x(2) - t_x(1);
if abs(delta_t - (t_g(2) - t_g(1))) > 1e-10 
    error(['Time sample interval mismatch for functions x(t) and g(t)']);
end

%  Set up vectors for time reversed g and for the plotting versions of x
%  and g which will span the full time range to be plotted.
N_x = length(x);
N_g = length(g);
t_g_rev = -fliplr(t_g);
g_rev  = fliplr(g);
g_width = t_g_rev(end)-t_g_rev(1);
gap = 50*delta_t;
%t_range = [t_x(1)-g_width-gap, t_x(end)+g_width+gap];
t_range = [(min([t_g_rev(1),t_x(1),t_x(1)+t_g(1)-g_width])-gap),...
    (max([t_x(end),t_g(end),t_g(end)+t_x(end)])+gap)];
t_plot = [t_range(1):delta_t:t_range(2)];
x_strtIdx = find(abs(t_plot - t_x(1)) < 0.1*delta_t);
x_plot = zeros(size(t_plot));
x_plot(x_strtIdx:x_strtIdx+N_x-1) = x;
plotMax = max([x,g,0]) + 0.2;
plotMin = min([x,g,0]) - 0.2;

%  Plot the original x(t) and g(t)
figure(1)
p = plot(t_range,[0, 0],'k',t_plot,x_plot,'b',[t_g(1)-delta_t, t_g, t_g(end)+delta_t],[0,g,0],'r');
axis([t_plot(1),t_plot(end),plotMin, plotMax]);
ax = gca;
ax.FontSize = 16;
p(1).LineWidth = 0.5;
p(2).LineWidth = 3;
p(3).LineWidth = 3;
legend('','x(t)','g(t)')
title('The Original Signals');
xlabel('t')
grid ON
    
pause

%  Calculate the convolution c(t) = x(t)*g(t) for each output time sample t
figure(2)
t_c = [];
c = [];
for t = [t_x(1)-t_g_rev(end)-gap:.1:t_x(end)-t_g_rev(1)+gap/2]
    % time reverse g, shift it by t, and insert it in a longer vector of
    % zeros which span the plotting range of time
    g_rev_strtIdx = find(abs(t_plot - (t_g_rev(1)+t)) < 0.1*delta_t);
    g_rev_plot = zeros(size(t_plot));
    g_rev_plot(g_rev_strtIdx:g_rev_strtIdx+N_g-1) = g_rev;
        
    %  Calculate the convolution integral using Riemann integral sum
    t_c = [t_c,t];
    c = [c, delta_t*sum(x_plot.*g_rev_plot)];

    % update the plot for x, g, and c using this time shift t
    p = plot(t_range,[0, 0],'k',t_plot,x_plot,'b',...
        t_plot,g_rev_plot,'r',t_c,c,'g');
    axis([t_plot(1),t_plot(end),plotMin, plotMax]);
    ax = gca;
    ax.FontSize = 16;
    p(1).LineWidth = 0.5;
    p(2).LineWidth = 3;
    p(3).LineWidth = 3;
    p(4).LineWidth = 3;
    legend('','x(t)','g(t-\tau)','c(t) = x(t)*g(t)')
    xlabel('t')
    title('Graphical Convolution');
    time = round(t,2);
    text(t_range(1)+gap,plotMax-.2,['t = ',num2str(time)],'FontSize',18);
    grid ON
    drawnow
    if manual_shift 
        input('');
    else
        pause(0.01);
    end
end

end