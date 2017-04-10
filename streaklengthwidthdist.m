function measurements = streaklengthwidthdist(binaryImage)

% labeledImage = bwlabel(binaryImage);
measurements = regionprops(logical(binaryImage), 'Area');
boundaries = bwboundaries(binaryImage);
numberOfBoundaries = size(measurements, 1);
figure(1)
imshow(binaryImage)
pause()
for blobIndex = 1 : numberOfBoundaries
	thisBoundary = boundaries{blobIndex};
	x = thisBoundary(:, 2); % x = columns.
	y = thisBoundary(:, 1); % y = rows.
	
	% Find which two bounary points are farthest from each other.
	maxDistance = -inf;
	for k = 1 :1: size(x,1)
		distances = sqrt( (x(k) - x) .^ 2 + (y(k) - y) .^ 2 );
		[thisMaxDistance, indexOfMaxDistance] = max(distances);
		if thisMaxDistance > maxDistance
			maxDistance = thisMaxDistance;
			index1 = k;
			index2 = indexOfMaxDistance;
		end
	end
	
	% Find the midpoint of the line.
	xMidPoint = mean([x(index1), x(index2)]);
	yMidPoint = mean([y(index1), y(index2)]);
	longSlope = (y(index1) - y(index2)) / (x(index1) - x(index2));
	perpendicularSlope = -1/longSlope;
	b=yMidPoint-perpendicularSlope*xMidPoint;
	% Use point slope formula (y-ym) = slope * (x - xm) to get points
	y1=perpendicularSlope*x(index1)+b;
	y2=perpendicularSlope*x(index2)+b;
    if longSlope==0;
        deltay=sqrt((y(index1)-y(index2))^2+(x(index1)-x(index2))^2);
        y1=yMidPoint-0.5*deltay;
        y2=yMidPoint+0.5*deltay;
        % Get the profile perpendicular to the midpoint so we can find out when if first enters and last leaves the object.
        [cx,cy,c] = improfile(binaryImage,[xMidPoint, xMidPoint], [y1, y2], 1000);
    elseif isinf(longSlope)==1
        deltax=sqrt((y(index1)-y(index2))^2+(x(index1)-x(index2))^2);
        x1=xMidPoint-0.5*deltax;
        x2=xMidPoint+0.5*deltax;
        % Get the profile perpendicular to the midpoint so we can find out when if first enters and last leaves the object.
        [cx,cy,c] = improfile(binaryImage,[x1, x2], [yMidPoint, yMidPoint], 1000);
    else
        % Get the profile perpendicular to the midpoint so we can find out when if first enters and last leaves the object.
        [cx,cy,c] = improfile(binaryImage,[x(index1), x(index2)], [y1, y2], 1000);
    end
	
	% Get rid of NAN's that occur when the line's endpoints go above or below the image.
	c(isnan(c)) = 0;
	firstIndex = find(c, 1, 'first');	%SOMETHING WRONG
	lastIndex = find(c, 1, 'last');		%SOMETHING WRONG
	% Compute the distance of that perpendicular width.
	perpendicularWidth = sqrt( (cx(firstIndex) - cx(lastIndex)) .^ 2 + (cy(firstIndex) - cy(lastIndex)) .^ 2 );
	% Get the average perpendicular width.  This will approximately be the area divided by the longest length.
 	averageWidth = measurements(blobIndex).Area / maxDistance;
	
	% Plot the boundaries, line, and midpoints over the two images.
	% Plot the boundary over the gray scale image
	figure(1)
	hold on
	plot(x, y, 'y-', 'LineWidth', 3);
	% For this blob, put a line between the points farthest away from each other.
	plot([x(index1), x(index2)], [y(index1), y(index2)], 'Color', 'r', 'LineWidth', 3);
	plot(xMidPoint, yMidPoint, 'r*', 'MarkerSize', 15, 'LineWidth', 2);
    % Plot perpendicular line.  Make it green across the whole image but magenta inside the blob.
	if longSlope==0
        plot([xMidPoint,xMidPoint],[y1,y2],'Color','g','LineWidth',3);
    else
        plot([x(index1), x(index2)], [y1, y2], 'Color', 'g', 'LineWidth', 3);	
    end
	plot([cx(firstIndex), cx(lastIndex)], [cy(firstIndex), cy(lastIndex)], 'Color', 'm', 'LineWidth', 3);%SOMETHING WRONG
	hold off
	pause()
	
	measurements(blobIndex).Length=maxDistance;
	measurements(blobIndex).Width=perpendicularWidth;
	measurements(blobIndex).AveWidth=averageWidth;
	measurements(blobIndex).Distance=maxDistance-averageWidth;	
end