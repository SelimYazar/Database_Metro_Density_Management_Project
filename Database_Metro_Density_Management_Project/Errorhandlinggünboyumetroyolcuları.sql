CREATE PROCEDURE ErrGünBoyuMetroYolcuları
	@MetroID int, 
	@ITarih date
AS
BEGIN
    DECLARE @GünBoyuGirenYolcuSayısı INT;
    DECLARE @GünBoyuÇıkanYolcuSayısı INT;

    -- TRY...CATCH bloğu ile hata kontrolü yapılır
    BEGIN TRY
        SELECT @GünBoyuGirenYolcuSayısı = COALESCE(SUM(GirenYolcu), 0),
               @GünBoyuÇıkanYolcuSayısı = COALESCE(SUM(ÇıkanYolcu), 0)
        FROM Geçiş g 
        JOIN Vagon v ON g.VagonID = v.ID 
        JOIN Metro m ON v.MetroID = m.ID
        WHERE g.Tarih = @ITarih AND m.ID = @MetroID AND g.Saat BETWEEN '00:00:00' AND '23:59:59';
    END TRY
    BEGIN CATCH
        -- Hata durumunda, değişkenlere 0 değeri atanıyor
        SET @GünBoyuGirenYolcuSayısı = 0;
        SET @GünBoyuÇıkanYolcuSayısı = 0;
    END CATCH;

    -- Sonuç seti döndürülür
    SELECT GünBoyuGirenYolcuSayısı = @GünBoyuGirenYolcuSayısı, GünBoyuÇıkanYolcuSayısı = @GünBoyuÇıkanYolcuSayısı;
END;

EXEC ErrGünBoyuMetroYolcuları 1, '2024-01-06'
