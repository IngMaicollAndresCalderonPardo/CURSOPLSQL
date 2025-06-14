-- agrupacion convencional
SELECT cod_ciclo, 
       tipo_act, 
       tipo_sub_act, 
       sum(lc.vlr_sdo_fact)
  FROM linea l, linea_cuenta lc
  WHERE lc.seq_linea = l.seq_linea
    AND l.seq_troncal = 0
    AND l.tipo_act in ('R','P')
    and cod_ciclo in (1,2)
   GROUP BY cod_ciclo, 
            tipo_act, 
            tipo_sub_act
;
-- agrupacion mediante ROLLUP
SELECT cod_ciclo, 
       tipo_act, 
       tipo_sub_act, 
       sum(lc.vlr_sdo_fact)
  FROM linea l, linea_cuenta lc
  WHERE lc.seq_linea = l.seq_linea
    AND l.seq_troncal = 0
    AND l.tipo_act in ('R','P')
    and cod_ciclo in (1,2)
   GROUP BY ROLLUP(cod_ciclo, 
                   tipo_act, 
                   tipo_sub_act)
;
-- agrupacion mediante ROLLUP Parcial
SELECT cod_ciclo, 
       tipo_act, 
       tipo_sub_act, 
       sum(lc.vlr_sdo_fact)
  FROM linea l, linea_cuenta lc
  WHERE lc.seq_linea = l.seq_linea
    AND l.seq_troncal = 0
    AND l.tipo_act in ('R','P')
    and cod_ciclo in (1,2)
   GROUP BY cod_ciclo,
	          ROLLUP(tipo_act, 
                   tipo_sub_act)
;
-- agrupacion mediante ROLLUP Parcial
SELECT cod_ciclo, 
       tipo_act, 
       tipo_sub_act, 
       sum(lc.vlr_sdo_fact)
  FROM linea l, linea_cuenta lc
  WHERE lc.seq_linea = l.seq_linea
    AND l.seq_troncal = 0
    AND l.tipo_act in ('R','P')
    and cod_ciclo in (1,2)
   GROUP BY cod_ciclo,
            tipo_act,
	          ROLLUP(tipo_sub_act)
;
-- agrupacion mediante CUBE
SELECT cod_ciclo, 
       tipo_act, 
       tipo_sub_act, 
       sum(lc.vlr_sdo_fact)
  FROM linea l, linea_cuenta lc
  WHERE lc.seq_linea = l.seq_linea
    AND l.seq_troncal = 0
    AND l.tipo_act in ('R','P')
    and cod_ciclo in (1,2)
   GROUP BY CUBE(cod_ciclo, 
                 tipo_act, 
                 tipo_sub_act)
;
-- agrupacion mediante CUBE Parcial
SELECT cod_ciclo, 
       tipo_act, 
       tipo_sub_act, 
       sum(lc.vlr_sdo_fact)
  FROM linea l, linea_cuenta lc
  WHERE lc.seq_linea = l.seq_linea
    AND l.seq_troncal = 0
    AND l.tipo_act in ('R','P')
    and cod_ciclo in (1,2)
   GROUP BY cod_ciclo, 
	          CUBE(tipo_act, 
                 tipo_sub_act)
;
-- agrupacion mediante ROLLUP, usando GROUPING
SELECT cod_ciclo, 
       tipo_act, 
       tipo_sub_act, 
       sum(lc.vlr_sdo_fact),
       grouping(cod_ciclo) totaliza_ciclo,
       grouping(tipo_act) totaliza_actividad,
       grouping(tipo_sub_act) totaliza_subactividad
  FROM linea l, linea_cuenta lc
  WHERE lc.seq_linea = l.seq_linea
    AND l.seq_troncal = 0
    AND l.tipo_act in ('R','P')
    and cod_ciclo in (1,2)
   GROUP BY ROLLUP(cod_ciclo, 
                   tipo_act, 
                   tipo_sub_act)
;
-- agrupacion mediante ROLLUP, usando GROUPING
SELECT decode(grouping(cod_ciclo), 1, 'Total General',
              decode(grouping(tipo_Act), 1, 'Total x Ciclo')) texto,
       cod_ciclo, 
       tipo_act, 
       tipo_sub_act, 
       sum(lc.vlr_sdo_fact),
       grouping(cod_ciclo) totaliza_ciclo,
       grouping(tipo_act) totaliza_actividad,
       grouping(tipo_sub_act) totaliza_subactividad
  FROM linea l, linea_cuenta lc
  WHERE lc.seq_linea = l.seq_linea
    AND l.seq_troncal = 0
    AND l.tipo_act in ('R','P')
    and cod_ciclo in (1,2)
   GROUP BY ROLLUP(cod_ciclo, 
                   tipo_act, 
                   tipo_sub_act)
;
-- agrupacion mediante ROLLUP, usando GROUPING_ID
SELECT cod_ciclo, 
       tipo_act, 
       tipo_sub_act, 
       sum(lc.vlr_sdo_fact),
       grouping(cod_ciclo) totaliza_ciclo,
       grouping(tipo_act) totaliza_actividad,
       grouping(tipo_sub_act) totaliza_subactividad,
       GROUPING_ID(cod_ciclo, tipo_act, tipo_sub_act) id
  FROM linea l, linea_cuenta lc
  WHERE lc.seq_linea = l.seq_linea
    AND l.seq_troncal = 0
    AND l.tipo_act in ('R','P')
    and cod_ciclo in (1,2)
   GROUP BY ROLLUP(cod_ciclo, 
                   tipo_act, 
                   tipo_sub_act)
;
-- Ejemplo de Ranking
-- Análisis de las llamadas de ayer
SELECT a_suscriber_number,
       SUM(round(gen.pak_horas.min_y_seg_a_min(chargeable_duration))) trafico,
       RANK () OVER (ORDER BY round(SUM(gen.pak_horas.min_y_seg_a_min(chargeable_duration))) desc ) lugar
FROM fac.otros_cargos2
WHERE date_start_charging BETWEEN to_date('20071122','yyyymmdd') AND to_date('20071123','yyyymmdd')
  AND tariff_class = 2
  AND a_suscriber_number BETWEEN 6799800 AND 6799899
GROUP BY a_suscriber_number
ORDER BY 3
;
-- Ejemplo de Ranking con NULLS FIRST/LAST
-- las dependencias que mas tickets grabaron este mes
SELECT d.nombre, tickets,
       RANK() OVER(ORDER BY tickets DESC NULLS last) rango
FROM (SELECT u.dependencia, 
			       count(*) tickets
			FROM ats.solicitud_mto s, ats.usuario u
			WHERE s.solicitante = u.usuario
			  AND TO_CHAR(s.fecha, 'yyyymm') = '200711'
			GROUP BY u.dependencia) t, ats.dependencia d
WHERE t.dependencia(+) = d.dependencia
ORDER BY 3
;
SELECT d.nombre, tickets,
       RANK() OVER(ORDER BY tickets DESC NULLS LAST) rango
FROM (SELECT u.dependencia, 
			       count(*) tickets
			FROM ats.solicitud_mto s, ats.usuario u
			WHERE s.solicitante = u.usuario
			  AND TO_CHAR(s.fecha, 'yyyymm') = '200711'
			GROUP BY u.dependencia) t, ats.dependencia d
WHERE t.dependencia(+) = d.dependencia
ORDER BY 3
;
-- Ejemplo de DENSE Ranking con NULLS FIRST/LAST
-- las dependencias que mas tickets grabaron este mes
SELECT d.nombre, tickets,
       dense_RANK() OVER(ORDER BY tickets DESC nulls last) rango
FROM (SELECT u.dependencia, 
			       count(*) tickets
			FROM ats.solicitud_mto s, ats.usuario u
			WHERE s.solicitante = u.usuario
			  AND TO_CHAR(s.fecha, 'yyyymm') = '200711'
			GROUP BY u.dependencia) t, ats.dependencia d
WHERE t.dependencia(+) = d.dependencia
ORDER BY 3
;
-- Ejemplo de Ranking
-- Análisis de las llamadas de ayer
-- Los 5 clientes que mas llamaron
SELECT linea, trafico, lugar
  FROM (SELECT a_suscriber_number linea,
				       SUM(gen.pak_horas.min_y_seg_a_min(chargeable_duration)) trafico,
				       RANK () OVER (ORDER BY SUM(gen.pak_horas.min_y_seg_a_min(chargeable_duration)) DESC) lugar
				FROM fac.otros_cargos2
				WHERE date_start_charging BETWEEN to_date('20071122','yyyymmdd') AND to_date('20071123','yyyymmdd')
				  AND tariff_class = 2
				  AND a_suscriber_number BETWEEN 6799800 AND 6799899
				GROUP BY a_suscriber_number
				ORDER BY 1 DESC)
  WHERE lugar <= 5
;
-- Los 5 clientes que MENOS llamaron
SELECT linea, trafico, lugar
  FROM (SELECT a_suscriber_number linea,
				       SUM(gen.pak_horas.min_y_seg_a_min(chargeable_duration)) trafico,
				       RANK () OVER (ORDER BY SUM(gen.pak_horas.min_y_seg_a_min(chargeable_duration))) lugar
				FROM fac.otros_cargos2
				WHERE date_start_charging BETWEEN to_date('20071122','yyyymmdd') AND to_date('20071123','yyyymmdd')
				  AND tariff_class = 2
				  AND a_suscriber_number BETWEEN 6799800 AND 6799899
				GROUP BY a_suscriber_number
				ORDER BY 1 DESC)
  WHERE lugar <= 5
;
-- Ejemplo de PERCENT_Ranking
-- las dependencias que mas tickets grabaron este mes
SELECT d.nombre, tickets,
       RANK() OVER(ORDER BY tickets DESC) rango,
       ROUND(PERCENT_RANK() OVER(ORDER BY tickets DESC), 3) * 100 porcentaje
FROM (SELECT u.dependencia, 
			       count(*) tickets
			FROM ats.solicitud_mto s, ats.usuario u
			WHERE s.solicitante = u.usuario
			  AND TO_CHAR(s.fecha, 'yyyymm') = '200711'
			GROUP BY u.dependencia) t, ats.dependencia d
WHERE t.dependencia = d.dependencia
ORDER BY 3
;
-- Ejemplo de NTILE
-- las dependencias que mas tickets grabaron este mes
SELECT d.nombre, tickets,
       RANK() OVER(ORDER BY tickets DESC) rango,
       NTILE (4) OVER(ORDER BY tickets DESC) grupito
FROM (SELECT u.dependencia, 
			       count(*) tickets
			FROM ats.solicitud_mto s, ats.usuario u
			WHERE s.solicitante = u.usuario
			  AND TO_CHAR(s.fecha, 'yyyymm') = '200711'
			GROUP BY u.dependencia) t, ats.dependencia d
WHERE t.dependencia = d.dependencia
ORDER BY 3
;
-- Ejemplo de RATIO_TO_REPORT
-- las dependencias que mas tickets grabaron este mes
SELECT d.nombre, tickets,
       RANK() OVER(ORDER BY tickets DESC) rango,
       ROUND(RATIO_TO_REPORT (SUM(tickets)) OVER() * 100, 2) aporte
FROM (SELECT u.dependencia, 
			       count(*) tickets
			FROM ats.solicitud_mto s, ats.usuario u
			WHERE s.solicitante = u.usuario
			  AND TO_CHAR(s.fecha, 'yyyymm') = '200711'
			GROUP BY u.dependencia) t, ats.dependencia d
WHERE t.dependencia = d.dependencia
GROUP BY d.nombre, tickets
ORDER BY 3
;
-- Ejemplo de RATIO_TO_REPORT
-- las dependencias que mas tickets grabaron este mes
SELECT d.nombre, tickets,
       SUM(tickets) OVER(ORDER BY tickets DESC ROWS UNBOUNDED PRECEDING) acumulado
FROM (SELECT u.dependencia, 
			       count(*) tickets
			FROM ats.solicitud_mto s, ats.usuario u
			WHERE s.solicitante = u.usuario
			  AND TO_CHAR(s.fecha, 'yyyymm') = '200711'
			GROUP BY u.dependencia) t, ats.dependencia d
WHERE t.dependencia = d.dependencia
GROUP BY d.nombre, tickets
ORDER BY 3
;
-- Ejemplo de Analisis LAG/LED
-- Comparacion con la fecha anterior
SELECT fecha, 
       cantidad,
       cantidad - LAG(cantidad, 1) OVER (ORDER BY fecha) diferencia
FROM (SELECT TRUNC(fecha_creacion) fecha,
             COUNT(*) cantidad
        FROM rms.oportunidad
        WHERE fecha_creacion >= to_date('20071101','yyyymmdd')
        GROUP BY TRUNC(fecha_creacion)
        ORDER BY 1
      )
;
-- Ejemplo de Analisis LAG/LED
-- Comparacion con la fecha siguiente
SELECT fecha, 
       cantidad,
       cantidad - LEAD(cantidad, 1) OVER (ORDER BY fecha) diferencia
FROM (SELECT TRUNC(fecha_creacion) fecha,
             COUNT(*) cantidad
        FROM rms.oportunidad
        WHERE fecha_creacion >= to_date('20071101','yyyymmdd')
        GROUP BY TRUNC(fecha_creacion)
        ORDER BY 1
      )
;

