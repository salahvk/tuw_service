import 'package:flutter/material.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class DescriptionEditWidget extends StatefulWidget {
  final String title;
  final String hint;

  final TextEditingController controller;
  const DescriptionEditWidget({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  State<DescriptionEditWidget> createState() => _DescriptionEditWidgetState();
}

class _DescriptionEditWidgetState extends State<DescriptionEditWidget> {
  bool isEditable = false;
  FocusNode nfocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    // final str = AppLocalizations.of(context)!;
    // final provider = Provider.of<DataProvider>(context, listen: true);
    return InkWell(
      onTap: () {
        setState(() {
          isEditable = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.grey.shade300,
              offset: const Offset(5, 8.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 10, 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Image.asset(ImageAssets.penEdit)],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              isEditable
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      child: TextField(
                        autofocus: true,
                        controller: widget.controller,
                        minLines: 3,
                        maxLines: 6,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        children: [
                          Text(
                            widget.controller.text.isEmpty
                                ? widget.title
                                : widget.controller.text,
                            style: getRegularStyle(
                                color: ColorManager.engineWorkerColor,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
