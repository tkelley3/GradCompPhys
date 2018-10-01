classdef particle
    %PARTICLE creates an object that allows modelling of motion    
    properties % is the list of quantities associated with this object
        mass
        vy
        vx
        x
        y
    end
    % methods refer to all the functions within this class. Used to modify
    % the object
    methods
        function self = particle(mass,x,y,vx,vy)
        % Constructor method also takes the name of the class. Assigns the
        % initial values to the class
           self.mass = mass;
           self.x=x;
           self.y=y;
           self.vx=vx;
           self.vy=vy;
        end
        % Evolves particle using the Euler method
        % NOTE: you should assign the object to the output so that the
        % method returns the altered class object
        function p =euler(self, fx, fy, dt)
            %EULER uses the euler rule to iterate the values of the
            %particle
            self.vx = self.vx + fx./self.mass.*dt;
            self.vy = self.vy + fy./self.mass.*dt;
            self.x = self.x + self.vx.*dt;
            self.y = self.y + self.vy.*dt;
            p = self;
        end
    end
end

