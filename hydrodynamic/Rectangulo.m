classdef Rectangulo
    properties
        largo
        ancho
    end
    methods
        function obj = Rectangulo(largo, ancho)
            obj.largo = largo;
            obj.ancho = ancho;
        end
        function area = calcularArea(obj)
            area = obj.largo * obj.ancho;
        end
        function perimetro = calcularPerimetro(obj)
            perimetro = 2 * (obj.largo + obj.ancho);
        end
    end
end
