function [H,D]=lpfilter(type,M,N,DO,n)
%LPFILTER Computes frequency domain lowpass filters.
%    H = LPFILTER(TYPE,M,N,DO,n) creates the transfer function of a lowpass filter, H for the specified TYPE and size (M-by-N).
%    To view the filter as an image or mesh plot, it should be centered using H=fftshift(H).
%
%    Valid values for TYOE,DO, and n are:
%   'ideal'             Ideal lowpass filter with cutoff frequency DO. n need not be supplied. DO must be positive.
%   'btw'               Butterworth lowpass filter of order n, and cuttoff DO. The default value for n is 1.0. DO must be positive.
%   'gaussian'       Gaussian lowpass filter with cuttoff (standard deviation) DO. n need not be supplied. DO must be positive.

% use function dftuv to set up the meshgrid arrays needed for computing the required distance.
[U,V]=dftuv(M,N);
%DO=% of the image width

% Compute the distances D(U,V).
D=sqrt(U.^2+V.^2);

% Begin filter computations
switch type
    case 'ideal'
        H=double(D<=DO);
    case 'btw'
        if nargin==4
            n=1;
        end
        H = 1./(1+(D./DO).^(2*n));
    case 'gaussian'
        H=exp(-(D.^2)./(2*(DO^2)));
    otherwise
        error('Unkown filter type.')
end