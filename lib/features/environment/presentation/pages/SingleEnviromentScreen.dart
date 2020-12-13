import 'package:auto_size_text/auto_size_text.dart';
import 'package:estuduff/core/resource/colors_estuduff.dart';
import 'package:estuduff/core/resource/dimensions.dart';
import 'package:estuduff/core/resource/fonts_estuduff.dart';
import 'package:estuduff/core/resource/strings_estuduff.dart';
import 'package:estuduff/core/ui/appbar_estuduff.dart';
import 'package:estuduff/core/util/profile-converter.dart';
import 'package:estuduff/features/environment/domain/entity/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleEnviromentScreen extends StatefulWidget {
  final Environment environment;

  SingleEnviromentScreen({Key key, this.environment}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SingleEnviromentScreenState();
  }
}

class _SingleEnviromentScreenState extends State<SingleEnviromentScreen> {
  Color enviromentColor;

  @override
  Widget build(BuildContext context) {
    this.enviromentColor =
        ProfileConverter.recoverProfileColor(widget.environment.studyProfile);
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return AppBarEstudUff(
      title: StringsEstudUff.enviroment_title,
      body: Container(
        alignment: Alignment.topCenter,
        padding: Dimensions.getEdgeInsetsAll(context, 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: Dimensions.getConvertedWidthSize(5, context),
                        color: enviromentColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: Image.asset(
                        StringsEstudUff.library_photo,
                        width: Dimensions.getConvertedWidthSize(100, context),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.getConvertedWidthSize(20, context),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        widget.environment.type.name,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: Dimensions.getTextSize(18, context),
                          fontFamily: FontsEstudUff.rubik,
                        ),
                      ),
                      Container(
                        width: Dimensions.getConvertedWidthSize(160, context),
                        height: Dimensions.getConvertedHeightSize(3, context),
                        color: enviromentColor,
                        margin: Dimensions.getEdgeInsetsSymetric(context,
                            vertical: 8),
                      ),
                      Text(
                        widget.environment.name,
                        style: TextStyle(
                          fontFamily: FontsEstudUff.open_sans,
                          color: ColorsEstudUff.mediumGrey,
                          fontSize: Dimensions.getTextSize(14, context),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.getConvertedHeightSize(30, context),
              ),
              _textInfo(
                  info: widget.environment.complement,
                  label: StringsEstudUff.enviroment_adress),
              _textInfo(
                  info: widget.environment.building.name,
                  label: StringsEstudUff.enviroment_building),
              _textInfo(
                  info: widget.environment.building.campus.name,
                  label: StringsEstudUff.enviroment_number),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _textInfo(
                      info: ProfileConverter.recoverStudyProfile(
                          widget.environment.studyProfile),
                      label: StringsEstudUff.enviroment_study_profile),
                  SvgPicture.asset(
                    ProfileConverter.recoverProfileIcon(
                      widget.environment.studyProfile,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textInfo({@required String label, @required String info}) {
    return Container(
      padding: Dimensions.getEdgeInsetsSymetric(context, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: Dimensions.getTextSize(16, context),
              fontFamily: FontsEstudUff.roboto,
            ),
          ),
          Text(
            info,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: Dimensions.getTextSize(14, context),
              fontFamily: FontsEstudUff.roboto,
            ),
          )
        ],
      ),
    );
  }
}
