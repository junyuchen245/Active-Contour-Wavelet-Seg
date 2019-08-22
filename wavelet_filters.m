% filter coefficients for orthogonal and bi-orthogonal filters
% Input:
%       choice: choice of filters, example: 'bio1'
% Output:
%       h0, f0, h1, f1: filter coefficients for low-pass and high-pass
%                       signals
% Author:
%       Junyu Chen (jchen245@jhu.edu)
%       Johns Hopkins University

function [h0, f0, h1, f1]=wavelet_filters(choice)
%% Half-band filter
p = 1/2048*[-5 0 49 0 -245 0 1225 2048 1225 0 -245 0 49 0 -5];

% plot coefficients:
%figure;
%stem(p) %
%title('Halfband filter P_0(z)')
% plot half-band filter's frequency response:
%figure; plot(abs(fft(p,1024)))

% find roots of the polynomial:
%roots(p)

% force some roots to -1:
b = poly(-ones(1,8)); % converts from roots to poly, b is coefficients;
q = deconv(p,b);

zq = roots(q);
zp = [zq; -ones(1,8)'];
disp(roots(p))
disp(zp)
% zplane
%figure;
%zplane(zp)
%title('Pole-Zero plot')

%% choice

if strcmp(choice, 'o1')
    % Real - coeffiecient and Orthogonality
    % 1. (zi, zi^*)  stay as a unit!    ........ Real - coeffiecient
    % 2. (zi, zi^-1) must be separated! ........ Orthogonality
    % split zeros into two polynomials: f0 is the inverst
    h0 = poly([zp(4:6);-1;-1;-1;-1]);
    f0 = poly([zp(1:3);-1;-1;-1;-1]);
    
    % normalize h0 and f0:
    
    f0 = sqrt(2).*f0./sum(f0);
    h0 = sqrt(2).*h0./sum(h0);%#conv(h0,f0)
    
    
    % flip
    h1 = f0.*[1 -1 1 -1 1 -1 1 -1];
    f1 = h0.*[-1 1 -1 1 -1 1 -1 1];
    
    
elseif strcmp(choice, 'o2')
    % Real - coeffiecient and Orthogonality
    % 1. (zi, zi^*)  stay as a unit!    ........ Real - coeffiecient
    % 2. (zi, zi^-1) must be separated! ........ Orthogonality
    
    h0 = poly([zp(1); zp(4:5);-1;-1;-1;-1]);
    f0 = poly([zp(6); zp(2:3);-1;-1;-1;-1]);
    
    f0 = sqrt(2).*f0./sum(f0);
    h0 = sqrt(2).*h0./sum(h0);
    
    % flip
    h1 = f0.*[1 -1 1 -1 1 -1 1 -1];
    f1 = h0.*[-1 1 -1 1 -1 1 -1 1];
    
    
    
elseif strcmp(choice, 'bio1')
    % Real - coeffiecient and symmetry
    % 1. (zi, zi^*)  stay as a unit!    ........ Real - coeffiecient
    % 2. (zi, zi^-1) stay as a unit!    ........ Symmetry
    
    h0 = poly([zp(1); zp(6);-1;-1;-1]);
    f0 = poly([zp(2:5);-1;-1;-1;-1;-1]);
    
    f0 = sqrt(2).*f0./sum(f0);
    h0 = sqrt(2).*h0./sum(h0);
    
    % flip
    h1 = f0.*[1 -1 1 -1 1 -1 1 -1 1 -1];
    f1 = h0.*[-1 1 -1 1 -1 1];
    
elseif strcmp(choice, 'bio2')
    % Real - coeffiecient and symmetry
    % 1. (zi, zi^*)  stay as a unit!    ........ Real - coeffiecient
    % 2. (zi, zi^-1) stay as a unit!    ........ Symmetry
    
    h0 = poly([zp(1);zp(6);-1;-1;-1;-1;-1;-1]);
    f0 = poly([zp(2:5);-1;-1]);
    
    f0 = sqrt(2).*f0./sum(f0);
    h0 = sqrt(2).*h0./sum(h0);
    
    % flip
    h1 = f0.*[1 -1 1 -1 1 -1 1];
    f1 = h0.*[-1 1 -1 1 -1 1 -1 1 -1];
    
elseif strcmp(choice, 'bio3')
    % Real - coeffiecient and Symmetry
    % 1. (zi, zi^*)  stay as a unit!    ........ Real - coeffiecient
    % 2. (zi, zi^-1) stay as a unit!    ........ Symmetry
    
    h0 = poly([zp(2:5);-1;-1;-1]);
    f0 = poly([zp(1);zp(6);-1;-1;-1;-1;-1]);
    
    f0 = sqrt(2).*f0./sum(f0);
    h0 = sqrt(2).*h0./sum(h0);
    
    % flip
    h1 = f0.*[1 -1 1 -1 1 -1 1 -1];
    f1 = h0.*[-1 1 -1 1 -1 1 -1 1];
    
elseif strcmp(choice, 'bio4')
    % Real - coeffiecient and symmetry
    % 1. (zi, zi^*)  stay as a unit!    ........ Real - coeffiecient
    % 2. (zi, zi^-1) stay as a unit!    ........ Symmetry
    % split zeros into two polynomials: f0 is the inverst
    
    h0 = poly([zp(2:5);-1;-1;-1;-1]);
    f0 = poly([zp(1);zp(6);-1;-1;-1;-1]);
    
    f0 = sqrt(2).*f0./sum(f0);
    h0 = sqrt(2).*h0./sum(h0);
    
    % flip
    h1 = f0.*[1 -1 1 -1 1 -1 1];
    f1 = h0.*[-1 1 -1 1 -1 1 -1 1 -1];
    
elseif strcmp(choice, 'bio5')
    % Real - coeffiecient and symmetry
    % 1. (zi, zi^*)  stay as a unit!    ........ Real - coeffiecient
    % 2. (zi, zi^-1) stay as a unit!    ........ Symmetry
    
    h0 = poly([-1;-1;-1;-1;-1]);
    f0 = poly([zp(1:6);-1;-1;-1]);
    
    f0 = sqrt(2).*f0./sum(f0);
    h0 = sqrt(2).*h0./sum(h0);
    
    % flip
    h1 = f0.*[1 -1 1 -1 1 -1 1 -1 1 -1];
    f1 = h0.*[-1 1 -1 1 -1 1];
    
elseif strcmp(choice, 'bio6')
    % Real - coeffiecient and symmetry
    % 1. (zi, zi^*)  stay as a unit!    ........ Real - coeffiecient
    % 2. (zi, zi^-1) stay as a unit!    ........ Symmetry    
    
    h0 = poly([zp(2:5);-1]);
    f0 = poly([zp(1);zp(6);-1*ones(7,1)]);
    
    % normalize h0 and f0:
    
    f0 = sqrt(2).*f0./sum(f0);
    h0 = sqrt(2).*h0./sum(h0);%#conv(h0,f0)
    
    % flip
    h1 = f0.*[1 -1 1 -1 1 -1 1 -1 1 -1];
    f1 = h0.*[-1 1 -1 1 -1 1];
    
end

