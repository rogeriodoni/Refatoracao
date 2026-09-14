*-- Encoder Values
#define EncoderValueCompressionLZW			2
#define EncoderValueCompressionCCITT3		3
#define EncoderValueCompressionCCITT4		4
#define EncoderValueCompressionRle			5
#define EncoderValueCompressionNone			6
#define EncoderValueTransformRotate90		13
#define EncoderValueTransformRotate180		14
#define EncoderValueTransformRotate270		15
#define EncoderValueTransformFlipHorizontal	16
#define EncoderValueTransformFlipVertical	17
#define EncoderValueMultiFrame				18
#define EncoderValueFrameDimensionTime		21
#define EncoderValueFrameDimensionPage		23

*-- RotateFlipType
#define RotateNoneFlipNone	0
#define Rotate90FlipNone	1
#define Rotate180FlipNone	2
#define Rotate270FlipNone	3

#define RotateNoneFlipX		4
#define Rotate90FlipX		5
#define Rotate180FlipX		6
#define Rotate270FlipX		7

#define RotateNoneFlipY		Rotate180FlipX
#define Rotate90FlipY		Rotate270FlipX
#define Rotate180FlipY		RotateNoneFlipX
#define Rotate270FlipY		Rotate90FlipX

#define RotateNoneFlipXY	Rotate180FlipNone
#define Rotate90FlipXY		Rotate270FlipNone
#define Rotate180FlipXY		RotateNoneFlipNone
#define Rotate270FlipXY		Rotate90FlipNone

*-- Quality mode constants
#define QualityModeInvalid	-1
#define QualityModeDefault	0
#define QualityModeLow		1	&& Best performance
#define QualityModeHigh		2	&& Best rendering quality

*-- Interpolation modes
#define InterpolationModeInvalid				-1
#define InterpolationModeDefault				0
#define InterpolationModeLowQuality				1
#define InterpolationModeHighQuality			2
#define InterpolationModeBilinear				3
#define InterpolationModeBicubic				4
#define InterpolationModeNearestNeighbor		5
#define InterpolationModeHighQualityBilinear	6
#define InterpolationModeHighQualityBicubic		7
