// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebPage {

 int get id; String get url; String get summary; int get importance; int get subjectId;
/// Create a copy of WebPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebPageCopyWith<WebPage> get copyWith => _$WebPageCopyWithImpl<WebPage>(this as WebPage, _$identity);

  /// Serializes this WebPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebPage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.importance, importance) || other.importance == importance)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,summary,importance,subjectId);

@override
String toString() {
  return 'WebPage(id: $id, url: $url, summary: $summary, importance: $importance, subjectId: $subjectId)';
}


}

/// @nodoc
abstract mixin class $WebPageCopyWith<$Res>  {
  factory $WebPageCopyWith(WebPage value, $Res Function(WebPage) _then) = _$WebPageCopyWithImpl;
@useResult
$Res call({
 int id, String url, String summary, int importance, int subjectId
});




}
/// @nodoc
class _$WebPageCopyWithImpl<$Res>
    implements $WebPageCopyWith<$Res> {
  _$WebPageCopyWithImpl(this._self, this._then);

  final WebPage _self;
  final $Res Function(WebPage) _then;

/// Create a copy of WebPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? summary = null,Object? importance = null,Object? subjectId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,importance: null == importance ? _self.importance : importance // ignore: cast_nullable_to_non_nullable
as int,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WebPage].
extension WebPagePatterns on WebPage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WebPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WebPage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WebPage value)  $default,){
final _that = this;
switch (_that) {
case _WebPage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WebPage value)?  $default,){
final _that = this;
switch (_that) {
case _WebPage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String url,  String summary,  int importance,  int subjectId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WebPage() when $default != null:
return $default(_that.id,_that.url,_that.summary,_that.importance,_that.subjectId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String url,  String summary,  int importance,  int subjectId)  $default,) {final _that = this;
switch (_that) {
case _WebPage():
return $default(_that.id,_that.url,_that.summary,_that.importance,_that.subjectId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String url,  String summary,  int importance,  int subjectId)?  $default,) {final _that = this;
switch (_that) {
case _WebPage() when $default != null:
return $default(_that.id,_that.url,_that.summary,_that.importance,_that.subjectId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WebPage implements WebPage {
  const _WebPage({required this.id, required this.url, required this.summary, required this.importance, required this.subjectId});
  factory _WebPage.fromJson(Map<String, dynamic> json) => _$WebPageFromJson(json);

@override final  int id;
@override final  String url;
@override final  String summary;
@override final  int importance;
@override final  int subjectId;

/// Create a copy of WebPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebPageCopyWith<_WebPage> get copyWith => __$WebPageCopyWithImpl<_WebPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebPageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebPage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.importance, importance) || other.importance == importance)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,summary,importance,subjectId);

@override
String toString() {
  return 'WebPage(id: $id, url: $url, summary: $summary, importance: $importance, subjectId: $subjectId)';
}


}

/// @nodoc
abstract mixin class _$WebPageCopyWith<$Res> implements $WebPageCopyWith<$Res> {
  factory _$WebPageCopyWith(_WebPage value, $Res Function(_WebPage) _then) = __$WebPageCopyWithImpl;
@override @useResult
$Res call({
 int id, String url, String summary, int importance, int subjectId
});




}
/// @nodoc
class __$WebPageCopyWithImpl<$Res>
    implements _$WebPageCopyWith<$Res> {
  __$WebPageCopyWithImpl(this._self, this._then);

  final _WebPage _self;
  final $Res Function(_WebPage) _then;

/// Create a copy of WebPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? summary = null,Object? importance = null,Object? subjectId = null,}) {
  return _then(_WebPage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,importance: null == importance ? _self.importance : importance // ignore: cast_nullable_to_non_nullable
as int,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
