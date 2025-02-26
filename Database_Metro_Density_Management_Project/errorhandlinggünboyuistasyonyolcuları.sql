CREATE PROCEDURE ErrGünBoyuistasyonYolcuları 
	@İstasyonID int, 
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
        JOIN Paks p ON g.PaksID = p.ID
        WHERE p.İstasyonID = @İstasyonID AND g.Tarih = @ITarih AND g.Saat BETWEEN '00:00:00' AND '23:59:59';
    END TRY
    BEGIN CATCH
        -- Hata durumunda, değişkenlere 0 değeri atanıyor
        SET @GünBoyuGirenYolcuSayısı = 0;
        SET @GünBoyuÇıkanYolcuSayısı = 0;
    END CATCH;

    -- Sonuç seti döndürülür
    SELECT GünBoyuGirenYolcuSayısı = @GünBoyuGirenYolcuSayısı, GünBoyuÇıkanYolcuSayısı = @GünBoyuÇıkanYolcuSayısı;
END;

EXEC ErrGünBoyuistasyonYolcuları 1, '2024-01-06'
DROP PROCEDURE ErrGünBoyuistasyonYolcuları