// To parse this JSON data, do
//
//     final wardData = wardDataFromJson(jsonString);

import 'dart:convert';

List<WardData> wardDataFromJson(String str) => List<WardData>.from(json.decode(str).map((x) => WardData.fromJson(x)));

String wardDataToJson(List<WardData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WardData {
    String label;
    String ocrText;
    int score;
    int xmin;
    int xmax;
    int ymin;
    int ymax;
    List<Cell> cells;
    String type;

    WardData({
        required this.label,
        required this.ocrText,
        required this.score,
        required this.xmin,
        required this.xmax,
        required this.ymin,
        required this.ymax,
        required this.cells,
        required this.type,
    });

    factory WardData.fromJson(Map<String, dynamic> json) => WardData(
        label: json["label"],
        ocrText: json["ocr_text"],
        score: json["score"],
        xmin: json["xmin"],
        xmax: json["xmax"],
        ymin: json["ymin"],
        ymax: json["ymax"],
        cells: List<Cell>.from(json["cells"].map((x) => Cell.fromJson(x))),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "ocr_text": ocrText,
        "score": score,
        "xmin": xmin,
        "xmax": xmax,
        "ymin": ymin,
        "ymax": ymax,
        "cells": List<dynamic>.from(cells.map((x) => x.toJson())),
        "type": type,
    };
}

class Cell {
    String id;
    int row;
    int col;
    int rowSpan;
    int colSpan;
    String label;
    int xmin;
    int ymin;
    int xmax;
    int ymax;
    double score;
    String text;
    String rowLabel;
    VerificationStatus verificationStatus;
    String status;
    String failedValidation;
    String labelId;

    Cell({
        required this.id,
        required this.row,
        required this.col,
        required this.rowSpan,
        required this.colSpan,
        required this.label,
        required this.xmin,
        required this.ymin,
        required this.xmax,
        required this.ymax,
        required this.score,
        required this.text,
        required this.rowLabel,
        required this.verificationStatus,
        required this.status,
        required this.failedValidation,
        required this.labelId,
    });

    factory Cell.fromJson(Map<String, dynamic> json) => Cell(
        id: json["id"],
        row: json["row"],
        col: json["col"],
        rowSpan: json["row_span"],
        colSpan: json["col_span"],
        label: json["label"],
        xmin: json["xmin"],
        ymin: json["ymin"],
        xmax: json["xmax"],
        ymax: json["ymax"],
        score: json["score"]?.toDouble(),
        text: json["text"],
        rowLabel: json["row_label"],
        verificationStatus: verificationStatusValues.map[json["verification_status"]]!,
        status: json["status"],
        failedValidation: json["failed_validation"],
        labelId: json["label_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "row": row,
        "col": col,
        "row_span": rowSpan,
        "col_span": colSpan,
        "label": label,
        "xmin": xmin,
        "ymin": ymin,
        "xmax": xmax,
        "ymax": ymax,
        "score": score,
        "text": text,
        "row_label": rowLabel,
        "verification_status": verificationStatusValues.reverse[verificationStatus],
        "status": status,
        "failed_validation": failedValidation,
        "label_id": labelId,
    };
}

enum VerificationStatus {
    CORRECTLY_PREDICTED
}

final verificationStatusValues = EnumValues({
    "correctly_predicted": VerificationStatus.CORRECTLY_PREDICTED
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
