<?php

namespace app\controllers\api;

use app\models\MasterUsers;
use ErrorException;
use Yii;
use yii\data\SqlDataProvider;

class PostController extends \yii\rest\Controller
{
    public function actionPostdata()
    {
        $firstname = !empty($_POST['firstname']) ? $_POST['firstname'] : '';
        $lastname = !empty($_POST['lastname']) ? $_POST['lastname'] : '';

        if ($firstname == null || $lastname == null) {
            $response = "false";
        } else {
            $model = new MasterUsers();
            $model->firstname = $firstname;
            $model->lastname = $lastname;
            if ($model->save()) {
                $response = "true";
            } else {
                $response = "false";
            }
            /* $connection = Yii::$app->db;
            $connection->createCommand()->insert('master_users', [
                'id' => NULL,
                'firstname' => $firstname,
                'lastname' => $lastname
            ])->execute(); */
            // $response = "true";
        }

        return [
            'data' => [
                'status' => $response
            ]
        ];
    }

    public function actionLogin()
    {
        $username = !empty($_POST['username']) ? $_POST['username'] : '';
        $password = !empty($_POST['password']) ? $_POST['password'] : '';
        $response = [];

        if ($username == null || $password == null) {
            $response = [
                'status' => 'false',
                'message' => 'Isi username / password',
            ];
        } else {
            $query = "SELECT a.nip,a.ni2,a.ket,a.nmp,IFNULL(b.ket,'') as jbt, a.pwd as password, a.ajb, a.adp, a.alv
                            FROM ifars.peg a
                            LEFT JOIN ifars.jbt b ON b.acc=a.ajb
                            LEFT JOIN ifars.lvl c ON c.acc=a.alv
                        WHERE a.aka='" . $username . "' AND a.pwd='" . $password . "' AND a.tgk='0000-00-00'";
            $item = new SqlDataProvider([
                'sql' => $query,
                'db' => 'db',
            ]);
            $item->pagination = FALSE;
            $dataUser = $item->getModels();

            if (!empty($dataUser)) {
                if ($password == $dataUser[0]['password']) {
                    $response = [
                        'status' => 'true',
                        'nip' => $dataUser[0]['nip'],
                        'ni2' => $dataUser[0]['ni2'],
                        'ket' => $dataUser[0]['ket'],
                        'nmp' => $dataUser[0]['nmp'],
                        'jbt' => $dataUser[0]['jbt'],
                        'ajb' => $dataUser[0]['ajb'],
                        'adp' => $dataUser[0]['adp'],
                        'alv' => $dataUser[0]['alv'],
                    ];
                }
            } else {
                $response = [
                    'status' => 'false',
                    'message' => 'username / password salah',
                ];
            }
        }

        return $response;
    }

    public function actionHasilkerja()
    {
        $idperiode = !empty($_POST['idperiode']) ? $_POST['idperiode'] : '';
        $nik = !empty($_POST['nik']) ? $_POST['nik'] : '';
        $a_1 = !empty($_POST['a_1']) ? $_POST['a_1'] : '';
        $a_2 = !empty($_POST['a_2']) ? $_POST['a_2'] : '';
        $a_3 = !empty($_POST['a_3']) ? $_POST['a_3'] : '';
        $a_4 = !empty($_POST['a_4']) ? $_POST['a_4'] : '';
        $ctt = !empty($_POST['ctt']) ? $_POST['ctt'] : '';
        $tgu = !empty($_POST['tgu']) ? $_POST['tgu'] : '';
        $response = [];

        $transaction = Yii::$app->db->beginTransaction();
        if ($idperiode == null || $nik == null || $a_1 == null || $a_2 == null || $a_3 == null || $a_4 == null) {
            $response = "unsuccessful";
        } else {
            try {
                if ($tgu == '') {
                    $query = "UPDATE penilaian.nilai_a_item a SET a.a_1='$a_1', a.a_2='$a_2', a.a_3='$a_3', a.a_4='$a_4', 
                                                    a.a1='$a_1', a.a2='$a_2', a.a3='$a_3', a.a4='$a_4',
                                                    a.ctt='$ctt', a.tgu=NOW(), a.upd=0
                                            WHERE a.iddetilperiode='" . $idperiode . "' AND a.nik='" . $nik . "'";
                } else {
                    $query = "UPDATE penilaian.nilai_a_item a SET a.a_1='$a_1', a.a_2='$a_2', a.a_3='$a_3', a.a_4='$a_4', 
                                                    a.a1='$a_1', a.a2='$a_2', a.a3='$a_3', a.a4='$a_4',
                                                    a.ctt='$ctt', a.tgu='$tgu', a.upd=0
                                            WHERE a.iddetilperiode='" . $idperiode . "' AND a.nik='" . $nik . "'";
                }

                $conn = Yii::$app->db;
                $conn->createCommand($query)->execute();
                $transaction->commit();

                $response = "success";
            } catch (ErrorException $ex) {
                $transaction->rollBack();
                $response = false;
            }
        }

        return ['status' => $response];
    }

    public function actionInserthasilkerjac()
    {
        $kdperiode = !empty($_POST['kdperiode']) ? $_POST['kdperiode'] : '';
        $nik = !empty($_POST['nik']) ? $_POST['nik'] : '';
        $idperiode = !empty($_POST['idperiode']) ? $_POST['idperiode'] : '';
        $c_4 = !empty($_POST['c_4']) ? $_POST['c_4'] : '';
        $response = [];

        $transaction = Yii::$app->db->beginTransaction();
        if ($kdperiode == null || $nik == null || $idperiode == null || $c_4 == null) {
            $response = "unsuccessful";
        } else {
            try {
                $query = "INSERT penilaian.nilai_c4 (penilaian.nilai_c4.kdperiode, penilaian.nilai_c4.nik, penilaian.nilai_c4.iddetilperiode, penilaian.nilai_c4.c_4, penilaian.nilai_c4.c4) VALUE ('$kdperiode','$nik','$idperiode','$c_4','$c_4')";
                $conn = Yii::$app->db;
                $conn->createCommand($query)->execute();
                $transaction->commit();

                $response = "success";
            } catch (ErrorException $ex) {
                $transaction->rollBack();
                $response = false;
            }
        }

        return ['status' => $response];
    }

    public function actionUpdatehasilkerjac()
    {
        $nik = !empty($_POST['nik']) ? $_POST['nik'] : '';
        $idperiode = !empty($_POST['idperiode']) ? $_POST['idperiode'] : '';
        $c_4 = !empty($_POST['c_4']) ? $_POST['c_4'] : '';
        $response = [];

        $transaction = Yii::$app->db->beginTransaction();
        if ($idperiode == null || $nik == null || $c_4 == null) {
            $response = "unsuccessful";
        } else {
            try {
                $query = "UPDATE penilaian.nilai_c4 SET penilaian.nilai_c4.c_4='" . $c_4 . "', penilaian.nilai_c4.c4='" . $c_4 . "' WHERE penilaian.nilai_c4.iddetilperiode='" . $idperiode . "' AND penilaian.nilai_c4.nik='" . $nik . "'";
                $conn = Yii::$app->db;
                $conn->createCommand($query)->execute();
                $transaction->commit();

                $response = "success";
            } catch (ErrorException $ex) {
                $transaction->rollBack();
                $response = false;
            }
        }

        return ['status' => $response];
    }

    public function actionInsertsikap()
    {

        $idperiode = !empty($_POST['idperiode']) ? $_POST['idperiode'] : '';
        $nik = !empty($_POST['nik']) ? $_POST['nik'] : '';
        $kdp = !empty($_POST['kdp']) ? $_POST['kdp'] : '';
        $catat1 = !empty($_POST['catat1']) ? $_POST['catat1'] : '';

        $response = [];

        $transaction = Yii::$app->db->beginTransaction();
        if ($idperiode == null || $nik == null || $kdp == null) {
            $response = "unsuccessful";
        } else {
            try {
                $query = "INSERT penilaian.nil_perilaku (penilaian.nil_perilaku.iddetilperiode,penilaian.nil_perilaku.nik,penilaian.nil_perilaku.kdp,penilaian.nil_perilaku.catat1,penilaian.nil_perilaku.crt,penilaian.nil_perilaku.tgu,penilaian.nil_perilaku.upd) 
                            VALUES ('" . $idperiode . "','" . $nik . "','" . $kdp . "','" . $catat1 . "',0,NOW(),0)";
                $conn = Yii::$app->db;
                $conn->createCommand($query)->execute();
                $transaction->commit();

                $response = "success";
            } catch (ErrorException $ex) {
                $transaction->rollBack();
                $response = false;
            }
        }

        return ['status' => $response];
    }

    public function actionDeletesikap()
    {

        $idperiode = !empty($_POST['idperiode']) ? $_POST['idperiode'] : '';
        $nik = !empty($_POST['nik']) ? $_POST['nik'] : '';
        $response = [];

        $transaction = Yii::$app->db->beginTransaction();
        if ($idperiode == null || $nik == null) {
            $response = "unsuccessful";
        } else {
            try {
                $query = "DELETE FROM penilaian.nil_perilaku WHERE penilaian.nil_perilaku.iddetilperiode='" . $idperiode . "' AND penilaian.nil_perilaku.nik='" . $nik . "'";
                $conn = Yii::$app->db;
                $conn->createCommand($query)->execute();
                $transaction->commit();

                $response = "success";
            } catch (ErrorException $ex) {
                $transaction->rollBack();
                $response = false;
            }
        }

        return ['status' => $response];
    }

    public function actionUpdatebukan()
    {

        $idperiode = !empty($_POST['idperiode']) ? $_POST['idperiode'] : '';
        $nik = !empty($_POST['nik']) ? $_POST['nik'] : '';
        $response = [];

        $transaction = Yii::$app->db->beginTransaction();
        if ($idperiode == null || $nik == null) {
            $response = "unsuccessful";
        } else {
            try {
                $query = "UPDATE penilaian.nilai_a_item a SET a.bukan = 1 WHERE a.nik = '" . $nik . "' AND a.iddetilperiode = '" . $idperiode . "'";
                $conn = Yii::$app->db;
                $conn->createCommand($query)->execute();
                $transaction->commit();

                $response = "success";
            } catch (ErrorException $ex) {
                $transaction->rollBack();
                $response = false;
            }
        }

        return ['status' => $response];
    }

    public function actionInserttemp()
    {
        $idperiode = !empty($_POST['idperiode']) ? $_POST['idperiode'] : '';
        $nik = !empty($_POST['nik']) ? $_POST['nik'] : '';

        // $ajb = !empty($_POST['ajb']) ? $_POST['ajb'] : '';
        $ats = !empty($_POST['ats']) ? $_POST['ats'] : '';
        $ajb_ats = !empty($_POST['ajb_ats']) ? $_POST['ajb_ats'] : '';

        $a1 = !empty($_POST['a1']) ? $_POST['a1'] : '';
        $a2 = !empty($_POST['a2']) ? $_POST['a2'] : '';
        $a3 = !empty($_POST['a3']) ? $_POST['a3'] : '';
        $a4 = !empty($_POST['a4']) ? $_POST['a4'] : '';
        $ctt = !empty($_POST['ctt']) ? $_POST['ctt'] : '';

        $c4 = !empty($_POST['c4']) ? $_POST['c4'] : '';
        $als_from = !empty($_POST['als_from']) ? $_POST['als_from'] : '';

        $response = [];

        $transaction = Yii::$app->db->beginTransaction();
        if ($idperiode == null || $nik == null || /* $ajb == null || */ $ats == null || $ajb_ats == null || /* $c4 == null || */ $als_from == null || $a1 == null || $a2 == null || $a3 == null || $a4 == null || $als_from == null) {
            $response = "unsuccessful";
        } else {
            try {
                $query = "INSERT penilaian.nilai_temp (
                    penilaian.nilai_temp.`iddetilperiode`, 
                    penilaian.nilai_temp.`nik`,
                    penilaian.nilai_temp.`ats`,
                    penilaian.nilai_temp.`ajb_ats`,
                    penilaian.nilai_temp.`bukan`,
                    penilaian.nilai_temp.`a1`,
                    penilaian.nilai_temp.`a2`,
                    penilaian.nilai_temp.`a3`,
                    penilaian.nilai_temp.`a4`,
                    penilaian.nilai_temp.`ctt`,
                    penilaian.nilai_temp.`c4`,
                    penilaian.nilai_temp.`tgu`,
                    penilaian.nilai_temp.`als_from`,
                    penilaian.nilai_temp.`als_to`,
                    penilaian.nilai_temp.`status`
                    ) VALUE (
                    '" . $idperiode . "',
                    '" . $nik . "',
                    '" . $ats . "',
                    '" . $ajb_ats . "',
                    NULL,
                    '" . $a1 . "',
                    '" . $a2 . "',
                    '" . $a3 . "',
                    '" . $a4 . "',
                    '" . $ctt . "',
                    '" . $c4 . "',
                    NOW(),
                    '" . $als_from . "',
                    NULL,
                    NULL
                    )";
                $conn = Yii::$app->db;
                $conn->createCommand($query)->execute();
                $transaction->commit();

                $response = "success";
            } catch (ErrorException $ex) {
                $transaction->rollBack();
                $response = false;
            }
        }

        return ['status' => $response];
    }

    public function actionInsertsecondtemp()
    {
        $idperiode = !empty($_POST['idperiode']) ? $_POST['idperiode'] : '';
        $nik = !empty($_POST['nik']) ? $_POST['nik'] : '';

        // $ajb = !empty($_POST['ajb']) ? $_POST['ajb'] : '';
        $ats = !empty($_POST['ats']) ? $_POST['ats'] : '';
        $ajb_ats = !empty($_POST['ajb_ats']) ? $_POST['ajb_ats'] : '';

        $a1 = !empty($_POST['a1']) ? $_POST['a1'] : '';
        $a2 = !empty($_POST['a2']) ? $_POST['a2'] : '';
        $a3 = !empty($_POST['a3']) ? $_POST['a3'] : '';
        $a4 = !empty($_POST['a4']) ? $_POST['a4'] : '';

        $c4 = !empty($_POST['c4']) ? $_POST['c4'] : '';

        $response = [];

        $transaction = Yii::$app->db->beginTransaction();
        if ($idperiode == null || $nik == null || /* $ajb == null || */ $ats == null || $ajb_ats == null || /* $c4 == null || */  $a1 == null || $a2 == null || $a3 == null || $a4 == null) {
            $response = "unsuccessful";
        } else {
            try {
                $query = "INSERT penilaian.nilai_temp (
                    penilaian.nilai_temp.`iddetilperiode`, 
                    penilaian.nilai_temp.`nik`,
                    penilaian.nilai_temp.`ats`,
                    penilaian.nilai_temp.`ajb_ats`,
                    penilaian.nilai_temp.`bukan`,
                    penilaian.nilai_temp.`a1`,
                    penilaian.nilai_temp.`a2`,
                    penilaian.nilai_temp.`a3`,
                    penilaian.nilai_temp.`a4`,
                    penilaian.nilai_temp.`ctt`,
                    penilaian.nilai_temp.`c4`,
                    penilaian.nilai_temp.`tgu`,
                    penilaian.nilai_temp.`als_from`,
                    penilaian.nilai_temp.`als_to`,
                    penilaian.nilai_temp.`status`
                    ) VALUE (
                    '" . $idperiode . "',
                    '" . $nik . "',
                    '" . $ats . "',
                    '" . $ajb_ats . "',
                    NULL,
                    '" . $a1 . "',
                    '" . $a2 . "',
                    '" . $a3 . "',
                    '" . $a4 . "',
                    NULL,
                    '" . $c4 . "',
                    NOW(),
                    NULL,
                    NULL,
                    2
                    )";
                $conn = Yii::$app->db;
                $conn->createCommand($query)->execute();
                $transaction->commit();

                $response = "success";
            } catch (ErrorException $ex) {
                $transaction->rollBack();
                $response = false;
            }
        }

        return ['status' => $response];
    }

    public function actionKonfirmasipengajuan()
    {
        $als_to = !empty($_POST['als_to']) ? $_POST['als_to'] : '';
        $status = !empty($_POST['status']) ? $_POST['status'] : '';
        $id = !empty($_POST['id']) ? $_POST['id'] : '';
        $idperiode = !empty($_POST['idperiode']) ? $_POST['idperiode'] : '';
        $nik = !empty($_POST['nik']) ? $_POST['nik'] : '';
        $ctt = !empty($_POST['ctt']) ? $_POST['ctt'] : '';

        $response = [];

        $transaction = Yii::$app->db->beginTransaction();
        if ($idperiode == null || $nik == null || /* $status == null ||  */ $id == null/*  || $als_to == null */) {
            $response = "unsuccessful";
        } else {
            try {
                $query = "UPDATE penilaian.nilai_temp as a set a.als_to='" . $als_to . "', a.status='" . $status . "', a.ctt='" . $ctt . "'
                            where a.id = '" . $id . "'
                            AND a.iddetilperiode = '" . $idperiode . "'
                            AND a.nik = '" . $nik . "'";
                $conn = Yii::$app->db;
                $conn->createCommand($query)->execute();
                $transaction->commit();

                $response = "success";
            } catch (ErrorException $ex) {
                $transaction->rollBack();
                $response = false;
            }
        }

        return ['status' => $response];
    }

    /* public function actionInserttotstatus()
    {
        $nik = !empty($_POST['nik']) ? $_POST['nik'] : '';
        $acc = !empty($_POST['acc']) ? $_POST['acc'] : '';
        $rej = !empty($_POST['rej']) ? $_POST['rej'] : '';
        $response = [];

        $transaction = Yii::$app->db->beginTransaction();
        if ($nik == null) {
            $response = "unsuccessful";
        } else {
            try {
                $query = "INSERT penilaian.nilai_tot_status (penilaian.nilai_tot_status.nik,penilaian.nilai_tot_status.tot_acc,penilaian.nilai_tot_status.tot_rej,penilaian.nilai_tot_status.tgi) VALUE ('" . $nik . "','" . $acc . "','" . $rej . "',NOW())";
                $conn = Yii::$app->db;
                $conn->createCommand($query)->execute();
                $transaction->commit();

                $response = "success";
            } catch (ErrorException $ex) {
                $transaction->rollBack();
                $response = false;
            }
        }

        return ['status' => $response];
    } */
}
