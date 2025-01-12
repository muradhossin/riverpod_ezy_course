// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'newsfeed_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NewsfeedStateModel _$NewsfeedStateModelFromJson(Map<String, dynamic> json) {
  return _NewsfeedStateModel.fromJson(json);
}

/// @nodoc
mixin _$NewsfeedStateModel {
  bool get isLoading => throw _privateConstructorUsedError;
  List<NewsFeedModel>? get newsFeedList => throw _privateConstructorUsedError;
  List<CommentModel>? get commentList => throw _privateConstructorUsedError;
  List<ReactionModel>? get reactionList => throw _privateConstructorUsedError;
  Map<String, List<CommentModel>>? get parentChildComments =>
      throw _privateConstructorUsedError;
  bool get isCommentLoading => throw _privateConstructorUsedError;

  /// Serializes this NewsfeedStateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewsfeedStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsfeedStateModelCopyWith<NewsfeedStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsfeedStateModelCopyWith<$Res> {
  factory $NewsfeedStateModelCopyWith(
          NewsfeedStateModel value, $Res Function(NewsfeedStateModel) then) =
      _$NewsfeedStateModelCopyWithImpl<$Res, NewsfeedStateModel>;
  @useResult
  $Res call(
      {bool isLoading,
      List<NewsFeedModel>? newsFeedList,
      List<CommentModel>? commentList,
      List<ReactionModel>? reactionList,
      Map<String, List<CommentModel>>? parentChildComments,
      bool isCommentLoading});
}

/// @nodoc
class _$NewsfeedStateModelCopyWithImpl<$Res, $Val extends NewsfeedStateModel>
    implements $NewsfeedStateModelCopyWith<$Res> {
  _$NewsfeedStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsfeedStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? newsFeedList = freezed,
    Object? commentList = freezed,
    Object? reactionList = freezed,
    Object? parentChildComments = freezed,
    Object? isCommentLoading = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      newsFeedList: freezed == newsFeedList
          ? _value.newsFeedList
          : newsFeedList // ignore: cast_nullable_to_non_nullable
              as List<NewsFeedModel>?,
      commentList: freezed == commentList
          ? _value.commentList
          : commentList // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>?,
      reactionList: freezed == reactionList
          ? _value.reactionList
          : reactionList // ignore: cast_nullable_to_non_nullable
              as List<ReactionModel>?,
      parentChildComments: freezed == parentChildComments
          ? _value.parentChildComments
          : parentChildComments // ignore: cast_nullable_to_non_nullable
              as Map<String, List<CommentModel>>?,
      isCommentLoading: null == isCommentLoading
          ? _value.isCommentLoading
          : isCommentLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsfeedStateModelImplCopyWith<$Res>
    implements $NewsfeedStateModelCopyWith<$Res> {
  factory _$$NewsfeedStateModelImplCopyWith(_$NewsfeedStateModelImpl value,
          $Res Function(_$NewsfeedStateModelImpl) then) =
      __$$NewsfeedStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<NewsFeedModel>? newsFeedList,
      List<CommentModel>? commentList,
      List<ReactionModel>? reactionList,
      Map<String, List<CommentModel>>? parentChildComments,
      bool isCommentLoading});
}

/// @nodoc
class __$$NewsfeedStateModelImplCopyWithImpl<$Res>
    extends _$NewsfeedStateModelCopyWithImpl<$Res, _$NewsfeedStateModelImpl>
    implements _$$NewsfeedStateModelImplCopyWith<$Res> {
  __$$NewsfeedStateModelImplCopyWithImpl(_$NewsfeedStateModelImpl _value,
      $Res Function(_$NewsfeedStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewsfeedStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? newsFeedList = freezed,
    Object? commentList = freezed,
    Object? reactionList = freezed,
    Object? parentChildComments = freezed,
    Object? isCommentLoading = null,
  }) {
    return _then(_$NewsfeedStateModelImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      newsFeedList: freezed == newsFeedList
          ? _value._newsFeedList
          : newsFeedList // ignore: cast_nullable_to_non_nullable
              as List<NewsFeedModel>?,
      commentList: freezed == commentList
          ? _value._commentList
          : commentList // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>?,
      reactionList: freezed == reactionList
          ? _value._reactionList
          : reactionList // ignore: cast_nullable_to_non_nullable
              as List<ReactionModel>?,
      parentChildComments: freezed == parentChildComments
          ? _value._parentChildComments
          : parentChildComments // ignore: cast_nullable_to_non_nullable
              as Map<String, List<CommentModel>>?,
      isCommentLoading: null == isCommentLoading
          ? _value.isCommentLoading
          : isCommentLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsfeedStateModelImpl
    with DiagnosticableTreeMixin
    implements _NewsfeedStateModel {
  const _$NewsfeedStateModelImpl(
      {this.isLoading = false,
      final List<NewsFeedModel>? newsFeedList,
      final List<CommentModel>? commentList,
      final List<ReactionModel>? reactionList,
      final Map<String, List<CommentModel>>? parentChildComments,
      this.isCommentLoading = false})
      : _newsFeedList = newsFeedList,
        _commentList = commentList,
        _reactionList = reactionList,
        _parentChildComments = parentChildComments;

  factory _$NewsfeedStateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsfeedStateModelImplFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  final List<NewsFeedModel>? _newsFeedList;
  @override
  List<NewsFeedModel>? get newsFeedList {
    final value = _newsFeedList;
    if (value == null) return null;
    if (_newsFeedList is EqualUnmodifiableListView) return _newsFeedList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CommentModel>? _commentList;
  @override
  List<CommentModel>? get commentList {
    final value = _commentList;
    if (value == null) return null;
    if (_commentList is EqualUnmodifiableListView) return _commentList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ReactionModel>? _reactionList;
  @override
  List<ReactionModel>? get reactionList {
    final value = _reactionList;
    if (value == null) return null;
    if (_reactionList is EqualUnmodifiableListView) return _reactionList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, List<CommentModel>>? _parentChildComments;
  @override
  Map<String, List<CommentModel>>? get parentChildComments {
    final value = _parentChildComments;
    if (value == null) return null;
    if (_parentChildComments is EqualUnmodifiableMapView)
      return _parentChildComments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final bool isCommentLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NewsfeedStateModel(isLoading: $isLoading, newsFeedList: $newsFeedList, commentList: $commentList, reactionList: $reactionList, parentChildComments: $parentChildComments, isCommentLoading: $isCommentLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NewsfeedStateModel'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('newsFeedList', newsFeedList))
      ..add(DiagnosticsProperty('commentList', commentList))
      ..add(DiagnosticsProperty('reactionList', reactionList))
      ..add(DiagnosticsProperty('parentChildComments', parentChildComments))
      ..add(DiagnosticsProperty('isCommentLoading', isCommentLoading));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsfeedStateModelImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._newsFeedList, _newsFeedList) &&
            const DeepCollectionEquality()
                .equals(other._commentList, _commentList) &&
            const DeepCollectionEquality()
                .equals(other._reactionList, _reactionList) &&
            const DeepCollectionEquality()
                .equals(other._parentChildComments, _parentChildComments) &&
            (identical(other.isCommentLoading, isCommentLoading) ||
                other.isCommentLoading == isCommentLoading));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_newsFeedList),
      const DeepCollectionEquality().hash(_commentList),
      const DeepCollectionEquality().hash(_reactionList),
      const DeepCollectionEquality().hash(_parentChildComments),
      isCommentLoading);

  /// Create a copy of NewsfeedStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsfeedStateModelImplCopyWith<_$NewsfeedStateModelImpl> get copyWith =>
      __$$NewsfeedStateModelImplCopyWithImpl<_$NewsfeedStateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsfeedStateModelImplToJson(
      this,
    );
  }
}

abstract class _NewsfeedStateModel implements NewsfeedStateModel {
  const factory _NewsfeedStateModel(
      {final bool isLoading,
      final List<NewsFeedModel>? newsFeedList,
      final List<CommentModel>? commentList,
      final List<ReactionModel>? reactionList,
      final Map<String, List<CommentModel>>? parentChildComments,
      final bool isCommentLoading}) = _$NewsfeedStateModelImpl;

  factory _NewsfeedStateModel.fromJson(Map<String, dynamic> json) =
      _$NewsfeedStateModelImpl.fromJson;

  @override
  bool get isLoading;
  @override
  List<NewsFeedModel>? get newsFeedList;
  @override
  List<CommentModel>? get commentList;
  @override
  List<ReactionModel>? get reactionList;
  @override
  Map<String, List<CommentModel>>? get parentChildComments;
  @override
  bool get isCommentLoading;

  /// Create a copy of NewsfeedStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsfeedStateModelImplCopyWith<_$NewsfeedStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
