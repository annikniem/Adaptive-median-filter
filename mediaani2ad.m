function [suodatettu] = mediaani2ad(kuva,Smax)
% mediaani2  Toteuttaa adaptiivisen mediaanisuodatuksen kuvalle
%
%   kuva = suodatettava kuva
%   Smax = maskin maksimikoko
%
%   kuvan reuna-alueen suodatusongelma on ratkaistu siten,
%   että kuvaa laajennetaan peilaamalla reunojen harmaasävyarvoja

c = (Smax - 1)/2;
    
% Kasvatetaan kuvamatriisin kokoa peilaamalla reunojen pikseleitä
[a, b] = size(kuva);
kuvan = zeros(a+2*c,b+2*c);      
kuvan(c+1:a+c,c+1:b+c) = kuva;  
    
kuvan(1:c,c+1:b+c) = kuva(1:c,1:b);
kuvan(1:a+c,b+c+1:b+2*c) = kuvan(1:a+c,b+1:b+c);   
kuvan(a+c+1:a+2*c,c+1:b+2*c) = kuvan(a+1:a+c,c+1:b+2*c); 
kuvan(1:a+2*c,1:c) = kuvan(1:a+2*c,c+1:2*c);   
    
a = size(kuvan,1);
b = size(kuvan,2);
ulostulo = kuvan;
suodin_koko = 3;

% Liikutetaan maskia koko kuvan yli
for i = c+1:a-c
    for j = c+1:b-c
        k = 1;
        
        % Kasvatetaan suodinta, kun ikkunan minimi tai maksimi
        % on yhtä suuri kuin mediaani ja suotimen koko on
        % pienempi kuin tai yhtäsuuri kuin maksimikoko
        while suodin_koko <= Smax
            ikkuna = kuvan(i-k:i+k,j-k:j+k);
            ikkuna = sort(sort(ikkuna,1),2);
            z_min = ikkuna(1,1);
            z_max = ikkuna(end, end);
            z_med = ikkuna(ceil(end/2), ceil(end/2));

            if z_min == z_med || z_max == z_med
                k = k+1;
                suodin_koko = suodin_koko + 2;
            else
                break;
            end
        end
        
        % Tarkistetaan onko suodatettava piste häiriö vai ei. Jos se
        % on häiriö, ulostulo on ikkunan mediaani, muuten itse piste.
        if kuvan(i,j) == z_max || kuvan(i,j) == z_min
            ulostulo(i,j) = z_med;
            suodin_koko = 3;
        else
            ulostulo(i,j) = kuvan(i,j);
            suodin_koko = 3;
        end

    end
end
% Palutetaan adaptiivisella mediaanisuotimella suodatettu 
% kuva ilman reunojen laajennuksia
[suodatettu] = uint8(ulostulo(c+1:a-c,c+1:b-c));
end