/*!
 * This file is part of MobileScanner.
 * Copyright (c) 2023 Emeric Grange - All Rights Reserved
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * \date      2023
 * \author    Emeric Grange <emeric.grange@gmail.com>
 */

#ifndef BARCODE_MANAGER_H
#define BARCODE_MANAGER_H
/* ************************************************************************** */

#include <QObject>
#include <QUrl>
#include <QString>
#include <QDateTime>

class Barcode;

/* ************************************************************************** */

/*!
 * \brief The BarcodeManager class
 */
class BarcodeManager: public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool hasBarcodes READ hasBarcodes NOTIFY barcodesChanged)
    Q_PROPERTY(int barcodesCount READ getBarcodesCount NOTIFY barcodesChanged)
    Q_PROPERTY(QVariant barcodes READ getBarcodes NOTIFY barcodesChanged)

    Q_PROPERTY(bool hasBarcodesHistory READ hasBarcodesHistory NOTIFY historyChanged)
    Q_PROPERTY(int barcodesHistoryCount READ getBarcodesHistoryCount NOTIFY historyChanged)
    Q_PROPERTY(QVariant barcodesHistory READ getBarcodesHistory NOTIFY historyChanged)

    QList <QObject *> m_barcodes_onscreen;
    QList <QObject *> m_barcodes_history;

    QStringList m_colorsAvailable = {
        "HotPink", "Tomato", "Yellow", "Orange", "Gold", "LimeGreen",
        "HotPink", "White", "Tomato", "Yellow", "Red", "Orange", "Gold", "LimeGreen", "Green",
        "MediumOrchid", "Purple", "YellowGreen", "LightYellow", "MediumVioletRed", "PeachPuff", "DodgerBlue",
        "Indigo", "Ivory", "DeepSkyBlue", "MistyRose", "DarkBlue", "MintCream", "Black", "OrangeRed",
        "PaleGreen", "Gainsboro", "PaleVioletRed", "Lavender", "Cyan", "MidnightBlue", "LightPink",
        "FireBrick", "Crimson", "DarkMagenta", "SteelBlue", "GreenYellow", "Brown", "DarkOrange",
        "Goldenrod", "DarkSeaGreen", "DarkRed", "LavenderBlush", "Violet", "Maroon", "Khaki",
        "WhiteSmoke", "Salmon", "Olive", "Orchid", "Fuchsia", "Pink", "LawnGreen", "Peru",
        "Grey", "Moccasin", "Beige", "Magenta", "DarkOrchid", "LightCyan", "RosyBrown", "GhostWhite",
        "MediumSeaGreen", "LemonChiffon", "Chocolate", "BurlyWood"
    };
    QStringList m_colorsLeft;
    QString getAvailableColor();

    static BarcodeManager *instance;
    BarcodeManager();
    ~BarcodeManager();

Q_SIGNALS:
    void barcodesChanged();
    void historyChanged();

public:
    static BarcodeManager *getInstance();

    Q_INVOKABLE bool loadImage(const QUrl &fileUrl);

    Q_INVOKABLE bool addBarcode(const QString &data, const QString &format,
                                const QString &enc, const QString &ecc,
                                const QPointF &p1, const QPointF &p2,  const QPointF &p3, const QPointF &p4,
                                const bool fromVideo = true);

    Q_INVOKABLE void addHistory(const QString &data, const QString &format,
                                const QString &enc, const QString &ecc);
    Q_INVOKABLE void removeHistory(const QString &data);

    bool hasBarcodes() const { return !m_barcodes_onscreen.isEmpty(); }
    int getBarcodesCount() const { return m_barcodes_onscreen.size(); }
    QVariant getBarcodes() const { return QVariant::fromValue(m_barcodes_onscreen); };

    bool hasBarcodesHistory() const { return !m_barcodes_history.isEmpty(); }
    int getBarcodesHistoryCount() const { return m_barcodes_history.size(); }
    QVariant getBarcodesHistory() const { return QVariant::fromValue(m_barcodes_history); };
};

/* ************************************************************************** */
#endif // BARCODE_MANAGER_H
