// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getWeatherHash() => r'32b0e60bf003151e7303467dfd5c95f7bafb3a17';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getWeather].
@ProviderFor(getWeather)
const getWeatherProvider = GetWeatherFamily();

/// See also [getWeather].
class GetWeatherFamily extends Family<AsyncValue<Weather>> {
  /// See also [getWeather].
  const GetWeatherFamily();

  /// See also [getWeather].
  GetWeatherProvider call({
    required double lat,
    required double lon,
  }) {
    return GetWeatherProvider(
      lat: lat,
      lon: lon,
    );
  }

  @override
  GetWeatherProvider getProviderOverride(
    covariant GetWeatherProvider provider,
  ) {
    return call(
      lat: provider.lat,
      lon: provider.lon,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getWeatherProvider';
}

/// See also [getWeather].
class GetWeatherProvider extends AutoDisposeFutureProvider<Weather> {
  /// See also [getWeather].
  GetWeatherProvider({
    required double lat,
    required double lon,
  }) : this._internal(
          (ref) => getWeather(
            ref as GetWeatherRef,
            lat: lat,
            lon: lon,
          ),
          from: getWeatherProvider,
          name: r'getWeatherProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getWeatherHash,
          dependencies: GetWeatherFamily._dependencies,
          allTransitiveDependencies:
              GetWeatherFamily._allTransitiveDependencies,
          lat: lat,
          lon: lon,
        );

  GetWeatherProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lat,
    required this.lon,
  }) : super.internal();

  final double lat;
  final double lon;

  @override
  Override overrideWith(
    FutureOr<Weather> Function(GetWeatherRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetWeatherProvider._internal(
        (ref) => create(ref as GetWeatherRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lat: lat,
        lon: lon,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Weather> createElement() {
    return _GetWeatherProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetWeatherProvider && other.lat == lat && other.lon == lon;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lat.hashCode);
    hash = _SystemHash.combine(hash, lon.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetWeatherRef on AutoDisposeFutureProviderRef<Weather> {
  /// The parameter `lat` of this provider.
  double get lat;

  /// The parameter `lon` of this provider.
  double get lon;
}

class _GetWeatherProviderElement
    extends AutoDisposeFutureProviderElement<Weather> with GetWeatherRef {
  _GetWeatherProviderElement(super.provider);

  @override
  double get lat => (origin as GetWeatherProvider).lat;
  @override
  double get lon => (origin as GetWeatherProvider).lon;
}

String _$getCurrentCityHash() => r'89968d60ffd8c930e779d76f20e66cd9491d475b';

/// See also [getCurrentCity].
@ProviderFor(getCurrentCity)
final getCurrentCityProvider = AutoDisposeFutureProvider<Position>.internal(
  getCurrentCity,
  name: r'getCurrentCityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCurrentCityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetCurrentCityRef = AutoDisposeFutureProviderRef<Position>;
String _$getLatLongFromAddressHash() =>
    r'4db4393ceb2ae1d7e44dd72def7cef298a3dc65c';

/// See also [getLatLongFromAddress].
@ProviderFor(getLatLongFromAddress)
const getLatLongFromAddressProvider = GetLatLongFromAddressFamily();

/// See also [getLatLongFromAddress].
class GetLatLongFromAddressFamily extends Family<AsyncValue<Location>> {
  /// See also [getLatLongFromAddress].
  const GetLatLongFromAddressFamily();

  /// See also [getLatLongFromAddress].
  GetLatLongFromAddressProvider call(
    String address,
  ) {
    return GetLatLongFromAddressProvider(
      address,
    );
  }

  @override
  GetLatLongFromAddressProvider getProviderOverride(
    covariant GetLatLongFromAddressProvider provider,
  ) {
    return call(
      provider.address,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getLatLongFromAddressProvider';
}

/// See also [getLatLongFromAddress].
class GetLatLongFromAddressProvider
    extends AutoDisposeFutureProvider<Location> {
  /// See also [getLatLongFromAddress].
  GetLatLongFromAddressProvider(
    String address,
  ) : this._internal(
          (ref) => getLatLongFromAddress(
            ref as GetLatLongFromAddressRef,
            address,
          ),
          from: getLatLongFromAddressProvider,
          name: r'getLatLongFromAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getLatLongFromAddressHash,
          dependencies: GetLatLongFromAddressFamily._dependencies,
          allTransitiveDependencies:
              GetLatLongFromAddressFamily._allTransitiveDependencies,
          address: address,
        );

  GetLatLongFromAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String address;

  @override
  Override overrideWith(
    FutureOr<Location> Function(GetLatLongFromAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetLatLongFromAddressProvider._internal(
        (ref) => create(ref as GetLatLongFromAddressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Location> createElement() {
    return _GetLatLongFromAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetLatLongFromAddressProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetLatLongFromAddressRef on AutoDisposeFutureProviderRef<Location> {
  /// The parameter `address` of this provider.
  String get address;
}

class _GetLatLongFromAddressProviderElement
    extends AutoDisposeFutureProviderElement<Location>
    with GetLatLongFromAddressRef {
  _GetLatLongFromAddressProviderElement(super.provider);

  @override
  String get address => (origin as GetLatLongFromAddressProvider).address;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
