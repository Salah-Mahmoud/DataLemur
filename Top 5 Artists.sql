WITH RankedArtists AS (
  SELECT
    a.artist_name,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS artist_rank
  FROM artists a
  JOIN songs s
    ON a.artist_id = s.artist_id
  JOIN global_song_rank g
    ON s.song_id = g.song_id
  WHERE g.rank <= 10
  GROUP BY a.artist_name
)
SELECT
  artist_name,
  artist_rank
FROM RankedArtists
WHERE artist_rank <= 5
ORDER BY artist_rank;
