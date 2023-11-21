function vr = stopSound(vr)
url = 'http://127.0.0.1:3000/stopSounds';
try
    options = weboptions('RequestMethod', 'get');
    webread(url, options);
    
catch ME
    disp(['Error: ' ME.message]);
end

end

