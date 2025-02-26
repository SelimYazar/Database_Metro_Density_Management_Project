CREATE PROCEDURE BelirliTarihVeSaatMetroYolcuSayıları 
	@MetroID int, 
	@TarihBaşlangıç date,
	@TarihBitiş date,
	@SaatBaşlangıç time,
	@SaatBitiş time
AS
BEGIN
	SELECT SUM(GirenYolcu) AS GirenYolcuSayısı, SUM(ÇıkanYolcu) AS ÇıkanYolcuSayısı
	FROM Geçiş g JOIN Vagon v ON g.VagonID = v.ID JOIN Metro m ON v.MetroID = m.ID
	WHERE (m.ID = @MetroID) AND (g.Tarih BETWEEN @TarihBaşlangıç AND @TarihBitiş) AND (g.Saat BETWEEN @SaatBaşlangıç and @SaatBitiş)
	--WHERE g.Tarih = @ITarih AND m.ID = @MetroID AND g.Saat BETWEEN '00:00:00' and '23:59:59'
END;

EXEC BelirliTarihVeSaatYolcuSayıları 1, '2024-01-06', '2024-01-07', '00:00:00', '23:59:59'