import QtQuick

import QtMultimedia
import QZXing

import ThemeEngine

QZXingFilter {
    id: zxingFilter
    videoSink: videoOutput.videoSink

    captureRect: {
        videoOutput.contentRect
        videoOutput.sourceRect
        return Qt.rect(videoOutput.sourceRect.width * videoOutput.captureRectStartFactorX,
                       videoOutput.sourceRect.height * videoOutput.captureRectStartFactorY,
                       videoOutput.sourceRect.width * videoOutput.captureRectFactorWidth,
                       videoOutput.sourceRect.height * videoOutput.captureRectFactorHeight)
    }

    decoder {
        tryHarder: settingsManager.scan_tryHarder

        enabledDecoders: QZXing.DecoderFormat_QR_CODE |
                         QZXing.DecoderFormat_DATA_MATRIX |
                         QZXing.DecoderFormat_UPC_E |
                         QZXing.DecoderFormat_UPC_A |
                         QZXing.DecoderFormat_UPC_EAN_EXTENSION |
                         QZXing.DecoderFormat_RSS_14 |
                         QZXing.DecoderFormat_RSS_EXPANDED |
                         QZXing.DecoderFormat_PDF_417 |
                         QZXing.DecoderFormat_MAXICODE |
                         QZXing.DecoderFormat_EAN_8 |
                         QZXing.DecoderFormat_EAN_13 |
                         QZXing.DecoderFormat_CODE_128 |
                         QZXing.DecoderFormat_CODE_93 |
                         QZXing.DecoderFormat_CODE_39 |
                         QZXing.DecoderFormat_CODABAR |
                         QZXing.DecoderFormat_ITF |
                         QZXing.DecoderFormat_Aztec

        onTagFound: (tag) => {
            console.log(tag + " | " + decoder.foundedFormat() + " | " + decoder.charSet())

            if (tag != tagText) {
                utilsApp.vibrate(33)

                zxingFilter.tagText = tag
                zxingFilter.tagFormat = decoder.foundedFormat()
                zxingFilter.tagEncoding = decoder.charSet()
            }

            //barcodeItem.visible = true
            //barcodeTxt.text = tag + " | " + decoder.foundedFormat()
            //if (decoder.charSet()) + " | " + decoder.charSet()
        }
    }

    property string tagText
    property string tagFormat
    property string tagEncoding

    property int framesDecoded: 0
    property real timePerFrameDecode: 0

    onDecodingStarted: {
        //console.log("onDecodingStarted()")
    }

    onDecodingFinished: (succeeded, decodeTime) => {
        //console.log("onDecodingFinished(" + succeeded + " / " + decodeTime + " ms)")

        if (decodeTime > 0) mspf.text = decodeTime + " ms"

        return

        timePerFrameDecode = (decodeTime + framesDecoded * timePerFrameDecode) / (framesDecoded + 1)
        framesDecoded++

        if (succeeded) {
            console.log("frame finished: " + succeeded, decodeTime, timePerFrameDecode, framesDecoded)
        }
    }
}