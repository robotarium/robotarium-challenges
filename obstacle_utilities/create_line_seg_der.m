function [ f ] = create_line_seg_der(line_segment)
%LINE_SEGMENT_DERIVATIVE Returns the derivative of the squared distance to
% a line segment.

    f = @derivative;
    
    function dp = derivative(point)
        s1 = line_segment(1:2); 
        s2 = line_segment(3:4);
        l2 = s2 - s1; 
        l2 = l2'*l2;
        p = point;
        
        % Don't divide by zero
        if(l2 == 0)
           dp = (s1 - p)';
           return
        end
        
        t = dot(p - s1, s2 - s1)/l2;
        
        if(t >= 1)
           % Project to t = 1
           dp = -(s1 - p)';
        elseif(t <= 0)
           % Project to 0
           dp = -(s2 - p)';
        else
           dp = (s1 + t*(s2 - s1) - p)'*(((s2 - s1)*(s2 - s1)')/l2 - eye(2));
        end
    end
end

