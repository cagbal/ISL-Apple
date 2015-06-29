function [ out ] = gaussian( X, Y, mu_x, mu_y, sigma )
%GAUSSIAN returns the 2D gaussian

% calculate 2d gaussian
out = 1/(2*pi*sigma^2)*exp(-((X-mu_x).^2+(Y-mu_y).^2)/(2*sigma^2));

% normalize the output
out = out/sum(out(:));

end

