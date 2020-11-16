clc;clear;clf;
grid = 100;      % please use even number such that mod(grid,2)=0
x=0:grid;   %   columns
y=x;                    %   rows
[x,y] = meshgrid(x,y);

u_cathode = 1;
u_anode = 0;
potential = ((u_anode + u_cathode)/2).*ones(grid+1);

w = 1.66667;    %   relaxation factor
e = 1;      %   probability exponent
%   boundary conditions
%   using dirichlet conditions at upper and lower sides of the lattice
%   using periodic conditions at the left and right sides of he lattice

potential(1,1:grid+1) = u_cathode;
potential(grid+1,1:grid+1) = u_anode;

%   seed
actual_point_row = 2;
actual_point_col = (grid/2)+1;

potential(actual_point_row,actual_point_col) = u_cathode;

cord_row = actual_point_row;
cord_col = actual_point_col;
contour(y,x,potential);
set(gcf,'color',[0.5 0.5 0.5]);
xlim([0 grid]);
ylim([0 grid]);
axis off;

iteration = 1;

while(potential(cord_row,cord_col)~=u_anode)
    probability = zeros(grid+1);
    possible_points = zeros(grid+1);    %   true or false matrix
    q = 0;
    format long;
    %%%%%%%%%%%%%%%%    solution to laplace equation
    
    for r = 2 : grid
        for c = 1 : grid +1
            if((potential(r,c)~=u_cathode) && (potential(r,c)~=u_anode))
                switch c
                    case 1
                        potential(r,c) = potential(r,c) + (w/4)*(...
                            (-4)*potential(r,c) + ...
                            potential(r-1,c) + ...  %current value top
                            potential(r,c+1) + ...  %current value right
                            potential(r+1,c) + ...  %previous value bottom
                            potential(r,grid+1) );     %previous value left
                    case grid+1
                        potential(r,c) = potential(r,c) + (w/4)*(...
                            (-4)*potential(r,c) + ...
                            potential(r-1,c) + ...  %current value top
                            potential(r,1) + ...  %current value right
                            potential(r+1,c) + ...  %previous value bottom
                            potential(r,c-1) );     %previous value left
                    otherwise
                        potential(r,c) = potential(r,c) + (w/4)*(...
                            (-4)*potential(r,c) + ...
                            potential(r-1,c) + ...  %current value top
                            potential(r,c+1) + ...  %current value right
                            potential(r+1,c) + ...  %previous value bottom
                            potential(r,c-1) );     %previous value left
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%     probability function calculating
    for r = 2 : grid
        for c = 2 : grid
            if (potential(r,c) == u_cathode)
                for a = -1:1
                    for b = -1:1
                        cord_row = r+a;
                        cord_col = c+b;
                        switch cord_col
                            case 0
                                cord_col = grid+1;
                            case (grid+2)
                                cord_col = 1;
                        end
                        switch a
                            case b
                                 if (potential(cord_row,cord_col) ~= u_cathode)
                                    possible_points(cord_row,cord_col) = 1;
                                    probability(cord_row,cord_col) = (1/sqrt(2))*abs(potential(r,c) - potential(cord_row,cord_col))^e + rand^e;
                                    q = q+1;
                                end
                            otherwise
                                if (potential(cord_row,cord_col) ~= u_cathode)
                                    possible_points(cord_row,cord_col) = 1;
                                    probability(cord_row,cord_col) = abs(potential(r,c) - potential(cord_row,cord_col))^e + rand^e;
                                    q = q+1;
                                end
                        end
                    end
                end
            end
        end
    end
    %%%%%%%%%%%%%%%     selecting possible candidate
    neighbor_potentials = zeros(1,q);
    Q=1;
    for r = 1:grid+1
        for c = 1:grid+1
            if (probability(r,c)~=0)
                neighbor_potentials(Q) = probability(r,c);
                Q = Q+1;
            end
        end
    end
    %%%%%%%%%%%%%%      normalizing probability function
    for r = 1:grid+1
        for c = 1:grid+1
            if (probability(r,c)~=0)
                probability(r,c) = probability(r,c)/sum(neighbor_potentials);
            end
        end
    end
    %%%%%%%%%%%%%%      selecting point to discharge breakdown pattern
    [next_point_row,next_point_col] = find(probability==max(max(probability)));
    
    for r =-1:1
        for c = -1:1
            cord_row = next_point_row + r;
            cord_col = next_point_col + c;
            switch cord_col
                case 0
                    cord_col = grid+1;
                case (grid+2)
                    cord_col = 1;
            end
            if (potential(cord_row, cord_col)==u_cathode)
                actual_point_row = cord_row;
                actual_point_col = cord_col;
            end
        end
    end
    
    potential(next_point_row,next_point_col) = u_cathode;
    iteration = iteration + 1;
    if(iteration==3000)
        break;
    end
    line([actual_point_row,next_point_row],[actual_point_col,next_point_col],'LineWidth',2,'Color','black');
    
    %plot([actual_point_row,next_point_row],[actual_point_col,next_point_col],'or')
    hold on;
    pause(0.000000001)
end
contour(y,x,potential,5);
fprintf('Número de iteraciones: %d\n',iteration);
