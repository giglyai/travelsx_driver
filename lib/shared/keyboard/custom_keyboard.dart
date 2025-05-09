import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';

class KeyboardDemo extends StatefulWidget {
  final int textMaxLength;
  final Function(String?) onChanged;

  final TextEditingController controller;

  const KeyboardDemo(
      {Key? key,
      required this.textMaxLength,
      required this.onChanged,
      required this.controller})
      : super(key: key);

  @override
  _KeyboardDemoState createState() => _KeyboardDemoState();
}

class _KeyboardDemoState extends State<KeyboardDemo> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomKeyboard(
      onTextInput: (myText) {
        _insertText(myText);
      },
      onBackspace: () {
        _backspace();
      },
    );
  }

  void _insertText(String myText) {
    if (_controller.text.length < widget.textMaxLength) {
      _controller.text += myText;
      widget.onChanged.call(_controller.text);
    }
  }

  void _backspace() {
    String? text = _controller.text;

    if (text != null && text.isNotEmpty) {
      List<String> tempTextString = text.split("");

      tempTextString.removeLast();

      text = tempTextString.join("");

      _controller.text = text;
    }
  }
}

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({
    Key? key,
    this.onTextInput,
    this.onBackspace,
  }) : super(key: key);

  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;

  void _textInputHandler(String text) => onTextInput?.call(text);

  void _backspaceHandler() => onBackspace?.call();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380 * SizeConfig.heightMultiplier!,
      width: 375 * SizeConfig.widthMultiplier!,
      color: const Color(0xffF9F9F9),
      child: Column(
        children: [
          buildRowOne(),
          buildRowTwo(),
          buildRowThree(),
          buildRowFour(),
        ],
      ),
    );
  }

  Expanded buildRowOne() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextKey(
            text: '1',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '2',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '3',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowTwo() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextKey(
            text: '4',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '5',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '6',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowThree() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextKey(
            text: '7',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '8',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '9',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowFour() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 72 * SizeConfig.widthMultiplier!,
            height: 72 * SizeConfig.widthMultiplier!,
          ),
          TextKey(
            text: '0',
            onTextInput: _textInputHandler,
          ),
          BackspaceKey(
            flex: 0,
            onBackspace: _backspaceHandler,
          ),
        ],
      ),
    );
  }
}

class TextKey extends StatelessWidget {
  const TextKey({
    Key? key,
    @required this.text,
    this.onTextInput,
    this.flex = 1,
  }) : super(key: key);

  final String? text;
  final ValueSetter<String>? onTextInput;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffF9F9F9),
      child: Container(
        width: 72 * SizeConfig.widthMultiplier!,
        height: 72 * SizeConfig.widthMultiplier!,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: InkWell(
          borderRadius:
              BorderRadius.circular(1000 * SizeConfig.widthMultiplier!),
          highlightColor: Colors.white,
          splashColor: Colors.white,
          onTap: () {
            onTextInput?.call(text!);
          },
          child: Center(
              child: Text(
            text!,
            style: TextStyle(
                color: const Color(0xff4B4B4B),
                fontSize: 30 * SizeConfig.textMultiplier!,
                fontWeight: FontWeight.w700),
          )),
        ),
      ),
    );
  }
}

class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    Key? key,
    this.onBackspace,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback? onBackspace;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Material(
        color: const Color(0xffF9F9F9),
        child: Container(
          width: 72 * SizeConfig.widthMultiplier!,
          height: 72 * SizeConfig.widthMultiplier!,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: InkWell(
            borderRadius:
                BorderRadius.circular(500 * SizeConfig.widthMultiplier!),
            highlightColor: Colors.white,
            splashColor: Colors.white,
            onTap: () {
              onBackspace?.call();
            },
            child: Center(
                child: Stack(
              children: [
                Center(
                  child: ImageLoader.svgPictureAssetImage(
                    imagePath: ImagePath.keyBoardDeleteIcon,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Icon(
                      Icons.close,
                      color: const Color(0xff4B4B4B).withOpacity(0.5),
                      size: 17,
                    ),
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
