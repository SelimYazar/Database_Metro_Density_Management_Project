--Vagondaki herhangi bir değer güncellenirse zamanı da güncelliyor (Son değişiklik zamanının kaydı için)
CREATE TRIGGER ZamanıGüncelle
ON Vagon
AFTER UPDATE
AS
BEGIN
	UPDATE Vagon
	SET 
		Tarih = GETDATE(), 
		Saat = CAST(SYSDATETIME() AS TIME)
		FROM inserted
		WHERE Vagon.ID = inserted.ID;
END;