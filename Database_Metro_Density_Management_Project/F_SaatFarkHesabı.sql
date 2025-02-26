CREATE FUNCTION SaatFarkHesabı
(
	@İlkSaat TIME,
	@İkinciSaat TIME
)
RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @Sonuç VARCHAR(255) = '';
    DECLARE @FarkSaniye INT = DATEDIFF(SECOND, @İlkSaat, @İkinciSaat);
    DECLARE @Saat INT = @FarkSaniye / 3600, @Dakika INT = (@FarkSaniye % 3600) / 60, @Saniye INT = @FarkSaniye % 60;

    IF @Saat > 0
        SET @Sonuç = CONCAT(@Saat, ' saat ');

    IF @Dakika > 0
        SET @Sonuç = CONCAT(@Sonuç, @Dakika, ' dakika ');

    IF @Saniye > 0
        SET @Sonuç = CONCAT(@Sonuç, @Saniye, ' saniye ');

	RETURN @Sonuç;
END;
