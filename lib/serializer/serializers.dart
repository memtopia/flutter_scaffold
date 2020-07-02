library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'serializers.g.dart';

/// Example of how to use built_value serialization.
///
/// Declare a top level [Serializers] field called serializers. Annotate it
/// with [SerializersFor] and provide a `const` `List` of types you want to
/// be serializable.
///
/// The built_value code generator will provide the implementation. It will
/// contain serializers for all the types asked for explicitly plus all the
/// types needed transitively via fields.
///
/// You usually only need to do this once per project.
@SerializersFor([

])
final Serializers serializers = _$serializers;
//final Serializers serializers = (_$serializers.toBuilder()
//      ..addBuilderFactory(
//          const FullType(BuiltMap, const [
//            const FullType(String),
//            const FullType(BuiltList, const [const FullType(Game)])
//          ]),
//          () => new MapBuilder<String, BuiltList<Game>>())
//      ..addBuilderFactory(const FullType(BuiltList, const [const FullType(Game)]), () => new ListBuilder<Game>()))
//    .build();

final Serializers standardSerializers = (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

///处理built_value暂时不支持直接序列化json-array的解决办法
T deserialize<T>(dynamic value) => standardSerializers.deserializeWith<T>(standardSerializers.serializerForType(T), value);

BuiltList<T> deserializeListOf<T>(dynamic value) => BuiltList.from(value.map((value) => deserialize<T>(value)).toList(growable: false));
