function [] = ihrri_show(im, varargin)
% [] =  ihrri_show(im, varargin)
%
% "Hand-made" function for showing an image with the screen resolution.
%
% VARARGIN arguments:
%
%   - varargin{1} : figure title.
%   - varargin{2} : figure to use (if not using new figure).
%   - varargin{3} : if true (and present), plot as surface, rather than
%                   image.
%
% See also figure, imagesc.
%
% Created: 05/21/2020 (mm/dd/yyyy)
% Author:   Fabien Momey
%           Laboratoire Hubert Curien UMR CNRS 5516,
%           Université Jean Monnet,
%           F-42000 Saint-Étienne,
%           France
%           fabien.momey@univ-st-etienne.fr
%
% Edited by Joseph Fiddes: 09/06/2024 (mm/dd/yyyy)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2020, Fabien Momey
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% 1. Redistributions of source code must retain the above copyright notice, this
%    list of conditions and the following disclaimer.
% 
% 2. Redistributions in binary form must reproduce the above copyright notice,
%    this list of conditions and the following disclaimer in the documentation
%    and/or other materials provided with the distribution.
% 
% 3. Neither the name of the copyright holder nor the names of its
%    contributors may be used to endorse or promote products derived from
%    this software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

persistent used_figures;
prev_fig = gcf;

figtitle = ['IHRRI Figure'];
bPlot_as_surface = false;

if (nargin <= 4)
    figure_to_use = 0;

    if (nargin == 4)
        if (varargin{3})
            bPlot_as_surface = true;
        end
    end
    if (nargin >= 3)
        figure_to_use = varargin{2};
    end

    if (nargin >= 2)
        if (ischar(varargin{1}))
            figtitle = varargin{1};
        else
            warning('Wrong type for FIGURE TITLE: must be CHAR. Keep default name.');
        end
    end
else
    error('Wrong number of VARARGIN arguments: only the FIGURE TITLE (CHAR), FIGURE TO USE (FIGURE OR NULL), and PLOT AS SURFACE (BOOL) can be specified');
end

% get screen size
scrsz = get(groot,'ScreenSize');
% get image size
imsize = size(im);

if figure_to_use == 0
    h = figure('Name',figtitle,'Position', ...
        [scrsz(3)/4, max(0, (scrsz(4)-imsize(1))/2), imsize(2), imsize(1)]);
else
    h = figure(figure_to_use);
end
disp(h.Number)
disp(im(1:3,1:7))


figure_already_used = ismember(h.Number, used_figures);

if bPlot_as_surface
    if figure_already_used
        cpos = campos;
        ctgt = camtarget;
        surf(1:size(im,1), 1:size(im,2), im, 'EdgeColor', 'none')
        campos(cpos)
        camtarget(ctgt)
    else
        surf(1:size(im,1), 1:size(im,2), im, 'EdgeColor', 'none')
    end
else
    imagesc(im); colormap(gray);
    axis xy;
end
ax = gca;


if ~figure_already_used
    ax.BoxStyle = 'full';
    ax.Box = 'on';
    ax.XTick = [];
    ax.YTick = [];
    set(ax,'Position',get(ax,'OuterPosition'));
    used_figures(end+1) = h.Number;
end

figure(prev_fig);