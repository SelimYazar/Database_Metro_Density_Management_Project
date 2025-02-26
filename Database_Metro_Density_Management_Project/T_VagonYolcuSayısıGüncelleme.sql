--Geçiş tablosuna değer kayıdı yapılırsa (vagona yolcu geçme durumu) vagondaki yolcu sayısını güncelliyor
CREATE TRIGGER VagonYolcuKayıt
ON Geçiş
AFTER INSERT
AS
BEGIN
    UPDATE Vagon
    SET 
		YolcuSayısı = YolcuSayısı + (inserted.GirenYolcu - inserted.ÇıkanYolcu),
		EngelliYolcuSayısı = EngelliYolcuSayısı + (inserted.GirenEngelliYolcu - inserted.ÇıkanEngelliYolcu)
	FROM inserted
	WHERE Vagon.ID = inserted.VagonID;
END;