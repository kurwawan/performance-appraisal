<?php

namespace app\controllers\api;

use Yii;
use yii\data\SqlDataProvider;
use yii\rest\Controller;

class GetController extends Controller
{
    public function actionGetallusers($id)
    {
        // $masterUser = MasterUsers::find()->all();
        if ($id == null) {
            $sql = "SELECT * FROM master_users";
        } else {
            $sql = "SELECT * FROM master_users where id = '$id'";
        }
        $item = new SqlDataProvider([
            'sql' => $sql,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        // return $masterUser;
        return $model;
    }

    public function actionListweek($nip)
    {
        $query = "SELECT DISTINCT b.minggu_n, b.tglawalminggu, b.tglakhirminggu, IFNULL(e.keterangan,'') nmperiode, a.iddetilperiode
                    FROM penilaian.nilai_a_item a
                    LEFT JOIN penilaian.minggu b ON b.iddetilperiode=a.iddetilperiode
                    LEFT JOIN penilaian.nilai_c4 c ON c.iddetilperiode=a.iddetilperiode AND c.nik=a.nik
                    LEFT JOIN ifars.peg d ON d.nip=a.nik
                    LEFT JOIN penilaian.periode e ON e.kdperiode=b.kdperiode
                    WHERE b.kdperiode IN (SELECT kdperiode FROM penilaian.periode WHERE setdefmg=1)
                    AND b.tglakhirminggu<NOW()
                    AND a.ats='" . $nip . "'
                    AND (LENGTH(a.ctt)=0
                    OR CONCAT(a.iddetilperiode,a.nik) NOT IN (SELECT CONCAT(x.iddetilperiode,x.nik) FROM penilaian.nil_perilaku X LEFT JOIN penilaian.minggu Y ON y.iddetilperiode=x.iddetilperiode LEFT JOIN penilaian.periode z ON z.kdperiode=y.kdperiode WHERE z.setdefmg=1)
                    OR a.a_1=''
                    OR a.a_2=''
                    OR a.a_3=''
                    OR a.a_4=''
                    OR (c.c_4='' AND (d.alv='L01' OR d.alv='L02' OR d.alv='L03' OR d.alv='L04' OR d.alv='L05' OR d.alv='L06' OR d.alv='L07' OR d.alv='L08')))
                    ORDER BY a.iddetilperiode";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionUpdatelistweek($nip)
    {
        $query = "SELECT DISTINCT b.minggu_n, b.tglawalminggu, b.tglakhirminggu, IFNULL(e.keterangan,'') nmperiode, a.iddetilperiode
                    FROM penilaian.nilai_a_item a
                    LEFT JOIN penilaian.minggu b ON b.iddetilperiode=a.iddetilperiode
                    LEFT JOIN penilaian.nilai_c4 c ON c.iddetilperiode=a.iddetilperiode AND c.nik=a.nik
                    LEFT JOIN ifars.peg d ON d.nip=a.nik
                    LEFT JOIN penilaian.periode e ON e.kdperiode=b.kdperiode
                    WHERE b.kdperiode IN (SELECT kdperiode FROM penilaian.periode WHERE setdefmg=1)
                    AND b.tglakhirminggu<NOW()
                    AND a.ats='" . $nip . "'
                    ORDER BY a.iddetilperiode";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionListteam($nip, $idperiode)
    {
        $query = "SELECT a.iddetilperiode, a.ats, a.nik AS nikb, b.nmp,b.alv, IFNULL(e.ket,'') jbtb, d.minggu_n, d.kdperiode
                    FROM penilaian.nilai_a_item a
                    LEFT JOIN ifars.peg b ON b.nip=a.nik
                    LEFT JOIN penilaian.nilai_c4 c ON c.iddetilperiode=a.iddetilperiode AND c.nik=a.nik
                    LEFT JOIN penilaian.minggu d ON d.iddetilperiode=a.iddetilperiode
                        LEFT JOIN ifars.jbt e ON e.acc=b.ajb
                    WHERE a.`iddetilperiode` = '" . $idperiode . "' AND a.ats='" . $nip . "'  AND a.bukan=0
                    AND (CONCAT(a.iddetilperiode,a.nik) NOT IN (SELECT CONCAT(x.iddetilperiode,x.nik) FROM penilaian.nil_perilaku X LEFT JOIN penilaian.minggu Y ON y.iddetilperiode=x.iddetilperiode LEFT JOIN penilaian.periode z ON z.kdperiode=y.kdperiode WHERE z.setdefmg=1)
                    OR a.a_1=''
                    OR a.a_2=''
                    OR a.a_3=''
                    OR a.a_4=''
                    OR (c.c_4='' AND (b.alv='L01' OR b.alv='L02' OR b.alv='L03' OR b.alv='L04' OR b.alv='L05' OR b.alv='L06' OR b.alv='L07' OR b.alv='L08')))
                    ORDER BY b.ket";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionUpdatelistteam($nip, $idperiode)
    {
        $query = "SELECT a.iddetilperiode, a.ats, a.nik AS nikb, b.nmp,b.alv, IFNULL(e.ket,'') jbtb, d.minggu_n, d.kdperiode
                    FROM penilaian.nilai_a_item a
                    LEFT JOIN ifars.peg b ON b.nip=a.nik
                    LEFT JOIN penilaian.nilai_c4 c ON c.iddetilperiode=a.iddetilperiode AND c.nik=a.nik
                    LEFT JOIN penilaian.minggu d ON d.iddetilperiode=a.iddetilperiode
                        LEFT JOIN ifars.jbt e ON e.acc=b.ajb
                    WHERE a.`iddetilperiode` = '" . $idperiode . "' AND a.ats='" . $nip . "'
                    AND a.a_1 IS NOT NULL
                    AND a.a_2 IS NOT NULL
                    AND a.a_3 IS NOT NULL
                    AND a.a_4 IS NOT NULL
                    ORDER BY b.ket";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionHasilkerjabyid($nip, $idperiode, $nik)
    {
        $query = "SELECT a.*,b.ket AS nmb,b.alv
                    FROM penilaian.nilai_a_item a
                    LEFT JOIN ifars.peg b ON b.nip=a.nik
                    WHERE a.iddetilperiode='" . $idperiode . "' 
                        AND a.ats='" . $nip . "' 
                        AND a.nik='" . $nik . "'
                    ORDER BY b.ket";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionHasilkerjaplusbyid($nik, $idperiode)
    {
        $query = "SELECT * FROM penilaian.nilai_c4 a WHERE a.nik = '" . $nik . "' AND a.iddetilperiode = '" . $idperiode . "'";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionSikap($idperiode, $nik)
    {
        $query = "SELECT a.iddetilperiode, a.nik, a.kdp, a.catat1 FROM penilaian.nil_perilaku a 
                    WHERE a.iddetilperiode='" . $idperiode . "' AND a.nik='" . $nik . "'";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionSikapbypoint($idperiode, $nik, $kdp)
    {
        if ($kdp == '') {
            $query = "SELECT a.iddetilperiode, a.nik, a.kdp, a.catat1 FROM penilaian.nil_perilaku a 
                    WHERE a.iddetilperiode='" . $idperiode . "' AND a.nik='" . $nik . "' AND a.kdp='" . $kdp . "'";
            $item = new SqlDataProvider([
                'sql' => $query,
                'db' => 'db',
            ]);
            $item->pagination = FALSE;
            $model = false;
            Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
            return $model;
        } else {
            $query = "SELECT a.iddetilperiode, a.nik, a.kdp, a.catat1 FROM penilaian.nil_perilaku a 
                    WHERE a.iddetilperiode='" . $idperiode . "' AND a.nik='" . $nik . "' AND a.kdp='" . $kdp . "'";
            $item = new SqlDataProvider([
                'sql' => $query,
                'db' => 'db',
            ]);
            $item->pagination = FALSE;
            $model = $item->getModels();
            Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
            return $model;
        }
    }

    public function actionChecklistweek($nip, $ajb)
    {
        $query = "SELECT DISTINCT b.minggu_n, b.tglawalminggu, b.tglakhirminggu, IFNULL(e.keterangan,'') nmperiode, a.iddetilperiode
                    FROM penilaian.nilai_a_item a
                    LEFT JOIN penilaian.minggu b ON b.iddetilperiode=a.iddetilperiode
                    LEFT JOIN penilaian.nilai_c4 c ON c.iddetilperiode=a.iddetilperiode AND c.nik=a.nik
                    LEFT JOIN ifars.peg d ON d.nip=a.nik
                    LEFT JOIN penilaian.periode e ON e.kdperiode=b.kdperiode
                    WHERE b.kdperiode IN (SELECT kdperiode FROM penilaian.periode WHERE setdefmg=1)
                    AND b.tglakhirminggu<NOW()
                    AND a.ats='" . $nip . "'
                    AND (LENGTH(a.ctt)=0
                    OR CONCAT(a.iddetilperiode,a.nik) NOT IN (SELECT CONCAT(x.iddetilperiode,x.nik) FROM penilaian.nil_perilaku X LEFT JOIN penilaian.minggu Y ON y.iddetilperiode=x.iddetilperiode LEFT JOIN penilaian.periode z ON z.kdperiode=y.kdperiode WHERE z.setdefmg=1)
                    OR a.a_1=''
                    OR a.a_2=''
                    OR a.a_3=''
                    OR a.a_4=''
                    OR (c.c_4='' AND (d.alv='L01' OR d.alv='L02' OR d.alv='L03' OR d.alv='L04' OR d.alv='L05' OR d.alv='L06' OR d.alv='L07' OR d.alv='L08' OR d.alv='L09')))
                        AND d.aka IS NOT NULL 
                    AND d.pwd IS NOT NULL 
                    AND d.tgk='0000-00-00'
                    AND (CASE WHEN SUBSTRING('" . $ajb . "',2,5) = '0000' THEN d.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,1),'%')
                            WHEN SUBSTRING('" . $ajb . "',3,5) = '000' THEN d.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,2),'%')
                            WHEN SUBSTRING('" . $ajb . "',4,5) = '00' THEN d.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,3),'%')
                            WHEN SUBSTRING('" . $ajb . "',5,5) = '0' THEN d.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,4),'%')
                        END)
                    AND d.adp = '" . $ajb . "'
                    AND d.ajb <> '" . $ajb . "'
                    ORDER BY a.iddetilperiode";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionChecklistteam($nip, $idperiode, $ajb)
    {
        $query = "SELECT a.nip, a.ket, a.nmp, IFNULL(b.ket,'') AS jbt, a.ajb, a.adp, d.ket
                            FROM ifars.peg a
                            LEFT JOIN ifars.jbt b ON b.acc = a.ajb
                            LEFT JOIN ifars.lvl d ON d.acc = a.alv
                            LEFT JOIN penilaian.nilai_a_item c ON c.nik = a.nip
                            WHERE c.iddetilperiode = '" . $idperiode . "'
                            AND c.ats = '" . $nip . "'			
                    AND a.tgk='0000-00-00'
                    AND (CASE WHEN SUBSTRING('" . $ajb . "',2,5) = '0000' THEN a.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,1),'%')
                        WHEN SUBSTRING('" . $ajb . "',3,5) = '000' THEN a.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,2),'%')
                        WHEN SUBSTRING('" . $ajb . "',4,5) = '00' THEN a.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,3),'%')
                        WHEN SUBSTRING('" . $ajb . "',5,5) = '0' THEN a.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,4),'%')
                    END)	
                    AND
                    (SELECT COUNT(f.iddetilperiode) FROM penilaian.nilai_a_item f
                    WHERE f.iddetilperiode= '" . $idperiode . "'
                    AND f.ats=a.nip
                    AND (f.a_1 IS NULL
                    OR f.a_2 IS NULL
                    OR f.a_3 IS NULL
                    OR f.a_4 IS NULL)
                    ) > 0
                    ORDER BY a.ket ASC";

        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionNilaicavl($idperiode, $nik)
    {
        $query = "SELECT * FROM penilaian.nilai_c4 a WHERE a.nik = '" . $nik . "' AND a.iddetilperiode = '" . $idperiode . "'";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionCheckprosespengajuan($idperiode, $nik)
    {
        $query = "SELECT a.id, a.als_from, a.als_to, a.status FROM penilaian.nilai_temp a
                    WHERE a.`nik` = '" . $nik . "'
                    AND a.`iddetilperiode` = '" . $idperiode . "'
                    AND a.`als_from` IS NOT NULL
                    AND a.`als_to` IS NULL
                    AND a.`status` IS NULL";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionListdateapprove()
    {
        $query = "SELECT substring(a.tgu,1,10) as tgu 
                    FROM penilaian.nilai_temp a
                    WHERE a.als_to IS NULL
		            AND a.status IS NULL
                    GROUP BY substring(a.tgu,1,10)
                    ORDER BY a.`tgu` ASC";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionListuserapprove($tgu)
    {
        $query = "SELECT a.*, b.nmp AS bawahan, d.`ket` AS jbt_bwh, b.alv, c.`nmp` AS atasan, e.`ket` AS jbt_ats, f.minggu_n, f.tglawalminggu, f.tglakhirminggu, IFNULL(g.keterangan,'') nmperiode, h.a_1, h.a_2, h.a_3, h.a_4, h.ctt AS ctt_old
                        FROM penilaian.nilai_temp a
                        LEFT JOIN ifars.peg b ON b.`nip` = a.nik
                        LEFT JOIN ifars.peg c ON c.`nip` = a.ats
                        LEFT JOIN ifars.jbt d ON d.acc = b.ajb
                        LEFT JOIN ifars.jbt e ON e.acc = a.ajb_ats
                        LEFT JOIN penilaian.minggu f ON f.iddetilperiode = a.iddetilperiode
                        LEFT JOIN penilaian.periode g ON g.kdperiode = f.kdperiode
                        LEFT JOIN penilaian.nilai_a_item h ON h.ats = a.ats
                        WHERE a.als_from IS NOT NULL
                        AND h.iddetilperiode = a.iddetilperiode
                        AND h.nik = a.nik
                        AND h.ajb_ats = a.ajb_ats
                        AND a.als_to IS NULL
                        AND a.status IS NULL
                        AND a.tgu LIKE CONCAT('" . $tgu . "','%')
                        ORDER BY a.tgu ASC";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionStatusbyid($idperiode, $nik)
    {
        $query = "SELECT a.id, a.als_to, a.status
                    FROM penilaian.nilai_temp a
                    WHERE a.iddetilperiode = '" . $idperiode . "'
                    AND a.nik = '" . $nik . "'
                    AND COALESCE(a.`status`,-1) <> 2
                    ORDER BY a.id DESC LIMIT 1";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionStatussecondbyid($idperiode, $nik)
    {
        $query = "SELECT a.id, a.als_to, a.status
                    FROM penilaian.nilai_temp a
                    WHERE a.iddetilperiode = '" . $idperiode . "'
                    AND a.nik = '" . $nik . "'
                    AND COALESCE(a.`status`,-1) = 2
                    ORDER BY a.id DESC LIMIT 1";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionIscheck($nik, $ajb)
    {
        $query = "SELECT COUNT(a.nip) AS total
                            FROM ifars.peg a
                            LEFT JOIN ifars.jbt b ON b.acc = a.ajb
                            LEFT JOIN ifars.lvl d ON d.acc = a.alv
                            LEFT JOIN penilaian.nilai_a_item c ON c.nik = a.nip
                    WHERE c.ats = '" . $nik . "'			
                    AND a.tgk='0000-00-00'
                    AND (CASE WHEN SUBSTRING('" . $ajb . "',2,5) = '0000' THEN a.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,1),'%')
                        WHEN SUBSTRING('" . $ajb . "',3,5) = '000' THEN a.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,2),'%')
                        WHEN SUBSTRING('" . $ajb . "',4,5) = '00' THEN a.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,3),'%')
                        WHEN SUBSTRING('" . $ajb . "',5,5) = '0' THEN a.ajb LIKE CONCAT(SUBSTRING('" . $ajb . "',1,4),'%')
                    END)
                    AND a.ajb <> '" . $ajb . "'			
                    AND
                    (SELECT COUNT(f.iddetilperiode) FROM penilaian.nilai_a_item f
                    WHERE f.ats=a.nip
                    AND (f.a_1 IS NULL
                    OR f.a_2 IS NULL
                    OR f.a_3 IS NULL
                    OR f.a_4 IS NULL)
                    ) > 0
                    AND d.ket LIKE '%struktural%'
                    ORDER BY a.ket ASC";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionHistoryatasan()
    {
        $query = "SELECT a.nik, a.ats, a.ajb_ats, c.nmp AS atasan
                        FROM penilaian.`nilai_temp` a
                        LEFT JOIN ifars.peg b ON b.nip=a.nik
                        LEFT JOIN ifars.peg c ON c.nip = a.ats
                        GROUP BY atasan";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionHistorybawahan($ats, $ajb_ats)
    {
        $query = "SELECT a.nik, b.nmp, c.nmp AS atasan
                        FROM penilaian.`nilai_temp` a
                        LEFT JOIN ifars.peg b ON b.nip=a.nik
                        LEFT JOIN ifars.peg c ON c.nip = a.ats
                        WHERE a.ats = '" . $ats . "'
                        AND a.ajb_ats = '" . $ajb_ats . "'
                        GROUP BY a.nik";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionHistoryperiode($nik)
    {
        $query = "SELECT a.`iddetilperiode`,  b.minggu_n, b.tglawalminggu, b.tglakhirminggu, IFNULL(c.keterangan,'') nmperiode
                        FROM penilaian.`nilai_temp` a
                        LEFT JOIN penilaian.minggu b ON b.iddetilperiode = a.iddetilperiode
                        LEFT JOIN penilaian.periode c ON c.kdperiode = b.kdperiode
                        WHERE a.nik = '" . $nik . "'
                        GROUP BY a.`iddetilperiode`
                        ORDER BY a.id ASC";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionHistorydetailperiode($nik, $idperiode)
    {
        $query = "SELECT a.id, a.`iddetilperiode`, a.`tgu`, a.`status`, a.`als_from`, a.`als_to`, a.`a1`, a.`a2`, a.`a3`, a.`a4`, a.`c4`
                        FROM penilaian.`nilai_temp` a
                        LEFT JOIN penilaian.minggu b ON b.iddetilperiode = a.iddetilperiode
                        LEFT JOIN penilaian.periode c ON c.kdperiode = b.kdperiode
                        WHERE a.nik = '" . $nik . "'
                        AND a.`iddetilperiode` = '" . $idperiode . "'
                        AND COALESCE(a.`status`,-1) <> 2
                        ORDER BY a.id ASC";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionHistorydetailnilaiawal($nik, $idperiode)
    {
        $query = "SELECT a.id, a.`iddetilperiode`, a.`tgu`, a.`status`, a.`als_from`, a.`als_to`, a.`a1`, a.`a2`, a.`a3`, a.`a4`, a.`c4`
                        FROM penilaian.`nilai_temp` a
                        LEFT JOIN penilaian.minggu b ON b.iddetilperiode = a.iddetilperiode
                        LEFT JOIN penilaian.periode c ON c.kdperiode = b.kdperiode
                        WHERE a.nik = '" . $nik . "'
                        AND a.`iddetilperiode` = '" . $idperiode . "'
                        AND COALESCE(a.`status`,-1) = 2
	                    ORDER BY a.id ASC LIMIT 1";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    /* public function actionCountaccept($nik)
    {
        $query = "SELECT COUNT(a.status) AS total
                    FROM penilaian.nilai_temp a
                    WHERE a.ats = '" . $nik . "'
                    AND COALESCE(a.`status`,-1) <> 2
                    AND a.status = 1
                    ORDER BY a.id DESC";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionCountreject($nik)
    {
        $query = "SELECT COUNT(a.status) AS total
                    FROM penilaian.nilai_temp a
                    WHERE a.ats = '" . $nik . "'
                    AND COALESCE(a.`status`,-1) <> 2
                    AND a.status = 0
                    ORDER BY a.id DESC";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    } */

    public function actionListhistory($nik)
    {
        $query = "SELECT a.id, d.nmp, a.`iddetilperiode`, a.`tgu`, a.`status`, IFNULL(c.keterangan,'') nmperiode, b.minggu_n, b.tglawalminggu, b.tglakhirminggu, a.`als_from`, a.`als_to`
                        FROM penilaian.`nilai_temp` a
                        LEFT JOIN penilaian.minggu b ON b.iddetilperiode = a.iddetilperiode
                        LEFT JOIN penilaian.periode c ON c.kdperiode = b.kdperiode
                        LEFT JOIN ifars.peg d ON d.nip=a.nik
                        WHERE a.ats = '" . $nik . "'
                        AND COALESCE(a.`status`,-1) <> 2
                        ORDER BY a.id DESC";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    /* public function actionCheckstotalstatus($nik)
    {
        $query = "SELECT a.nik, a.tot_acc, a.tot_rej
                        FROM penilaian.nilai_tot_status a
                        WHERE a.nik = '" . $nik . "'
                        ORDER BY a.id DESC";
        $item = new SqlDataProvider([
            'sql' => $query,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    } */
}
