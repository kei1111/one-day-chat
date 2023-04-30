// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'picker_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PickerPageStateTearOff {
  const _$PickerPageStateTearOff();

  _PickerPageState call({File? imageFile}) {
    return _PickerPageState(
      imageFile: imageFile,
    );
  }
}

/// @nodoc
const $PickerPageState = _$PickerPageStateTearOff();

/// @nodoc
mixin _$PickerPageState {
  File? get imageFile => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PickerPageStateCopyWith<PickerPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickerPageStateCopyWith<$Res> {
  factory $PickerPageStateCopyWith(
          PickerPageState value, $Res Function(PickerPageState) then) =
      _$PickerPageStateCopyWithImpl<$Res>;
  $Res call({File? imageFile});
}

/// @nodoc
class _$PickerPageStateCopyWithImpl<$Res>
    implements $PickerPageStateCopyWith<$Res> {
  _$PickerPageStateCopyWithImpl(this._value, this._then);

  final PickerPageState _value;
  // ignore: unused_field
  final $Res Function(PickerPageState) _then;

  @override
  $Res call({
    Object? imageFile = freezed,
  }) {
    return _then(_value.copyWith(
      imageFile: imageFile == freezed
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc
abstract class _$PickerPageStateCopyWith<$Res>
    implements $PickerPageStateCopyWith<$Res> {
  factory _$PickerPageStateCopyWith(
          _PickerPageState value, $Res Function(_PickerPageState) then) =
      __$PickerPageStateCopyWithImpl<$Res>;
  @override
  $Res call({File? imageFile});
}

/// @nodoc
class __$PickerPageStateCopyWithImpl<$Res>
    extends _$PickerPageStateCopyWithImpl<$Res>
    implements _$PickerPageStateCopyWith<$Res> {
  __$PickerPageStateCopyWithImpl(
      _PickerPageState _value, $Res Function(_PickerPageState) _then)
      : super(_value, (v) => _then(v as _PickerPageState));

  @override
  _PickerPageState get _value => super._value as _PickerPageState;

  @override
  $Res call({
    Object? imageFile = freezed,
  }) {
    return _then(_PickerPageState(
      imageFile: imageFile == freezed
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$_PickerPageState implements _PickerPageState {
  const _$_PickerPageState({this.imageFile});

  @override
  final File? imageFile;

  @override
  String toString() {
    return 'PickerPageState(imageFile: $imageFile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PickerPageState &&
            const DeepCollectionEquality().equals(other.imageFile, imageFile));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(imageFile));

  @JsonKey(ignore: true)
  @override
  _$PickerPageStateCopyWith<_PickerPageState> get copyWith =>
      __$PickerPageStateCopyWithImpl<_PickerPageState>(this, _$identity);
}

abstract class _PickerPageState implements PickerPageState {
  const factory _PickerPageState({File? imageFile}) = _$_PickerPageState;

  @override
  File? get imageFile;
  @override
  @JsonKey(ignore: true)
  _$PickerPageStateCopyWith<_PickerPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
