function [] = ihrri_show(im, varargin)
% [] =  ihrri_show(im, varargin)
%
% "Hand-made" function for showing an image with the screen resolution.
%
% VARARGIN arguments:
%
%   - varargin{1} : figure title.
%   - varargin{2} : figure to use (if not using new figure).
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

prev_fig = gcf;

figtitle = ['IHRRI Figure'];
if (nargin <= 3)
    figure_to_use = 0;
    if (nargin == 3)
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
    error('Wrong number of VARARGIN arguments: only the FIGURE TITLE (CHAR) and FIGURE TO USE (FIGURE OR NULL) can be specified');
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
imagesc(im); colormap(gray);
axis xy;
ax = gca;
if ~strcmp(ax.BoxStyle, 'full')
    ax.BoxStyle = 'full';
    ax.Box = 'on';
    ax.XTick = [];
    ax.YTick = [];
    set(ax,'Position',get(ax,'OuterPosition'));
end

figure(prev_fig);