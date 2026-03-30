// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_dao.dart';

// ignore_for_file: type=lint
class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prepTimeMinutesMeta = const VerificationMeta(
    'prepTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> prepTimeMinutes = GeneratedColumn<int>(
    'prep_time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cookTimeMinutesMeta = const VerificationMeta(
    'cookTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> cookTimeMinutes = GeneratedColumn<int>(
    'cook_time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<int> servings = GeneratedColumn<int>(
    'servings',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caloriesPerServingMeta =
      const VerificationMeta('caloriesPerServing');
  @override
  late final GeneratedColumn<int> caloriesPerServing = GeneratedColumn<int>(
    'calories_per_serving',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinPerServingMeta = const VerificationMeta(
    'proteinPerServing',
  );
  @override
  late final GeneratedColumn<double> proteinPerServing =
      GeneratedColumn<double>(
        'protein_per_serving',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _carbsPerServingMeta = const VerificationMeta(
    'carbsPerServing',
  );
  @override
  late final GeneratedColumn<double> carbsPerServing = GeneratedColumn<double>(
    'carbs_per_serving',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatPerServingMeta = const VerificationMeta(
    'fatPerServing',
  );
  @override
  late final GeneratedColumn<double> fatPerServing = GeneratedColumn<double>(
    'fat_per_serving',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ingredientsMeta = const VerificationMeta(
    'ingredients',
  );
  @override
  late final GeneratedColumn<String> ingredients = GeneratedColumn<String>(
    'ingredients',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPublicMeta = const VerificationMeta(
    'isPublic',
  );
  @override
  late final GeneratedColumn<bool> isPublic = GeneratedColumn<bool>(
    'is_public',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_public" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    description,
    instructions,
    prepTimeMinutes,
    cookTimeMinutes,
    servings,
    caloriesPerServing,
    proteinPerServing,
    carbsPerServing,
    fatPerServing,
    ingredients,
    imageUrl,
    category,
    isPublic,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_instructionsMeta);
    }
    if (data.containsKey('prep_time_minutes')) {
      context.handle(
        _prepTimeMinutesMeta,
        prepTimeMinutes.isAcceptableOrUnknown(
          data['prep_time_minutes']!,
          _prepTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('cook_time_minutes')) {
      context.handle(
        _cookTimeMinutesMeta,
        cookTimeMinutes.isAcceptableOrUnknown(
          data['cook_time_minutes']!,
          _cookTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    }
    if (data.containsKey('calories_per_serving')) {
      context.handle(
        _caloriesPerServingMeta,
        caloriesPerServing.isAcceptableOrUnknown(
          data['calories_per_serving']!,
          _caloriesPerServingMeta,
        ),
      );
    }
    if (data.containsKey('protein_per_serving')) {
      context.handle(
        _proteinPerServingMeta,
        proteinPerServing.isAcceptableOrUnknown(
          data['protein_per_serving']!,
          _proteinPerServingMeta,
        ),
      );
    }
    if (data.containsKey('carbs_per_serving')) {
      context.handle(
        _carbsPerServingMeta,
        carbsPerServing.isAcceptableOrUnknown(
          data['carbs_per_serving']!,
          _carbsPerServingMeta,
        ),
      );
    }
    if (data.containsKey('fat_per_serving')) {
      context.handle(
        _fatPerServingMeta,
        fatPerServing.isAcceptableOrUnknown(
          data['fat_per_serving']!,
          _fatPerServingMeta,
        ),
      );
    }
    if (data.containsKey('ingredients')) {
      context.handle(
        _ingredientsMeta,
        ingredients.isAcceptableOrUnknown(
          data['ingredients']!,
          _ingredientsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientsMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('is_public')) {
      context.handle(
        _isPublicMeta,
        isPublic.isAcceptableOrUnknown(data['is_public']!, _isPublicMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      )!,
      prepTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prep_time_minutes'],
      ),
      cookTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cook_time_minutes'],
      ),
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servings'],
      ),
      caloriesPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories_per_serving'],
      ),
      proteinPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per_serving'],
      ),
      carbsPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_per_serving'],
      ),
      fatPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per_serving'],
      ),
      ingredients: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredients'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      isPublic: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_public'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final int id;
  final String userId;
  final String name;
  final String? description;
  final String instructions;
  final int? prepTimeMinutes;
  final int? cookTimeMinutes;
  final int? servings;
  final int? caloriesPerServing;
  final double? proteinPerServing;
  final double? carbsPerServing;
  final double? fatPerServing;
  final String ingredients;
  final String? imageUrl;
  final String? category;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Recipe({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.instructions,
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.servings,
    this.caloriesPerServing,
    this.proteinPerServing,
    this.carbsPerServing,
    this.fatPerServing,
    required this.ingredients,
    this.imageUrl,
    this.category,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['instructions'] = Variable<String>(instructions);
    if (!nullToAbsent || prepTimeMinutes != null) {
      map['prep_time_minutes'] = Variable<int>(prepTimeMinutes);
    }
    if (!nullToAbsent || cookTimeMinutes != null) {
      map['cook_time_minutes'] = Variable<int>(cookTimeMinutes);
    }
    if (!nullToAbsent || servings != null) {
      map['servings'] = Variable<int>(servings);
    }
    if (!nullToAbsent || caloriesPerServing != null) {
      map['calories_per_serving'] = Variable<int>(caloriesPerServing);
    }
    if (!nullToAbsent || proteinPerServing != null) {
      map['protein_per_serving'] = Variable<double>(proteinPerServing);
    }
    if (!nullToAbsent || carbsPerServing != null) {
      map['carbs_per_serving'] = Variable<double>(carbsPerServing);
    }
    if (!nullToAbsent || fatPerServing != null) {
      map['fat_per_serving'] = Variable<double>(fatPerServing);
    }
    map['ingredients'] = Variable<String>(ingredients);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['is_public'] = Variable<bool>(isPublic);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      instructions: Value(instructions),
      prepTimeMinutes: prepTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(prepTimeMinutes),
      cookTimeMinutes: cookTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(cookTimeMinutes),
      servings: servings == null && nullToAbsent
          ? const Value.absent()
          : Value(servings),
      caloriesPerServing: caloriesPerServing == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesPerServing),
      proteinPerServing: proteinPerServing == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinPerServing),
      carbsPerServing: carbsPerServing == null && nullToAbsent
          ? const Value.absent()
          : Value(carbsPerServing),
      fatPerServing: fatPerServing == null && nullToAbsent
          ? const Value.absent()
          : Value(fatPerServing),
      ingredients: Value(ingredients),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      isPublic: Value(isPublic),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recipe(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      instructions: serializer.fromJson<String>(json['instructions']),
      prepTimeMinutes: serializer.fromJson<int?>(json['prepTimeMinutes']),
      cookTimeMinutes: serializer.fromJson<int?>(json['cookTimeMinutes']),
      servings: serializer.fromJson<int?>(json['servings']),
      caloriesPerServing: serializer.fromJson<int?>(json['caloriesPerServing']),
      proteinPerServing: serializer.fromJson<double?>(
        json['proteinPerServing'],
      ),
      carbsPerServing: serializer.fromJson<double?>(json['carbsPerServing']),
      fatPerServing: serializer.fromJson<double?>(json['fatPerServing']),
      ingredients: serializer.fromJson<String>(json['ingredients']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      category: serializer.fromJson<String?>(json['category']),
      isPublic: serializer.fromJson<bool>(json['isPublic']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'instructions': serializer.toJson<String>(instructions),
      'prepTimeMinutes': serializer.toJson<int?>(prepTimeMinutes),
      'cookTimeMinutes': serializer.toJson<int?>(cookTimeMinutes),
      'servings': serializer.toJson<int?>(servings),
      'caloriesPerServing': serializer.toJson<int?>(caloriesPerServing),
      'proteinPerServing': serializer.toJson<double?>(proteinPerServing),
      'carbsPerServing': serializer.toJson<double?>(carbsPerServing),
      'fatPerServing': serializer.toJson<double?>(fatPerServing),
      'ingredients': serializer.toJson<String>(ingredients),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'category': serializer.toJson<String?>(category),
      'isPublic': serializer.toJson<bool>(isPublic),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Recipe copyWith({
    int? id,
    String? userId,
    String? name,
    Value<String?> description = const Value.absent(),
    String? instructions,
    Value<int?> prepTimeMinutes = const Value.absent(),
    Value<int?> cookTimeMinutes = const Value.absent(),
    Value<int?> servings = const Value.absent(),
    Value<int?> caloriesPerServing = const Value.absent(),
    Value<double?> proteinPerServing = const Value.absent(),
    Value<double?> carbsPerServing = const Value.absent(),
    Value<double?> fatPerServing = const Value.absent(),
    String? ingredients,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> category = const Value.absent(),
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Recipe(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    instructions: instructions ?? this.instructions,
    prepTimeMinutes: prepTimeMinutes.present
        ? prepTimeMinutes.value
        : this.prepTimeMinutes,
    cookTimeMinutes: cookTimeMinutes.present
        ? cookTimeMinutes.value
        : this.cookTimeMinutes,
    servings: servings.present ? servings.value : this.servings,
    caloriesPerServing: caloriesPerServing.present
        ? caloriesPerServing.value
        : this.caloriesPerServing,
    proteinPerServing: proteinPerServing.present
        ? proteinPerServing.value
        : this.proteinPerServing,
    carbsPerServing: carbsPerServing.present
        ? carbsPerServing.value
        : this.carbsPerServing,
    fatPerServing: fatPerServing.present
        ? fatPerServing.value
        : this.fatPerServing,
    ingredients: ingredients ?? this.ingredients,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    category: category.present ? category.value : this.category,
    isPublic: isPublic ?? this.isPublic,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Recipe copyWithCompanion(RecipesCompanion data) {
    return Recipe(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      prepTimeMinutes: data.prepTimeMinutes.present
          ? data.prepTimeMinutes.value
          : this.prepTimeMinutes,
      cookTimeMinutes: data.cookTimeMinutes.present
          ? data.cookTimeMinutes.value
          : this.cookTimeMinutes,
      servings: data.servings.present ? data.servings.value : this.servings,
      caloriesPerServing: data.caloriesPerServing.present
          ? data.caloriesPerServing.value
          : this.caloriesPerServing,
      proteinPerServing: data.proteinPerServing.present
          ? data.proteinPerServing.value
          : this.proteinPerServing,
      carbsPerServing: data.carbsPerServing.present
          ? data.carbsPerServing.value
          : this.carbsPerServing,
      fatPerServing: data.fatPerServing.present
          ? data.fatPerServing.value
          : this.fatPerServing,
      ingredients: data.ingredients.present
          ? data.ingredients.value
          : this.ingredients,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      category: data.category.present ? data.category.value : this.category,
      isPublic: data.isPublic.present ? data.isPublic.value : this.isPublic,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('prepTimeMinutes: $prepTimeMinutes, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('servings: $servings, ')
          ..write('caloriesPerServing: $caloriesPerServing, ')
          ..write('proteinPerServing: $proteinPerServing, ')
          ..write('carbsPerServing: $carbsPerServing, ')
          ..write('fatPerServing: $fatPerServing, ')
          ..write('ingredients: $ingredients, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('category: $category, ')
          ..write('isPublic: $isPublic, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    name,
    description,
    instructions,
    prepTimeMinutes,
    cookTimeMinutes,
    servings,
    caloriesPerServing,
    proteinPerServing,
    carbsPerServing,
    fatPerServing,
    ingredients,
    imageUrl,
    category,
    isPublic,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.description == this.description &&
          other.instructions == this.instructions &&
          other.prepTimeMinutes == this.prepTimeMinutes &&
          other.cookTimeMinutes == this.cookTimeMinutes &&
          other.servings == this.servings &&
          other.caloriesPerServing == this.caloriesPerServing &&
          other.proteinPerServing == this.proteinPerServing &&
          other.carbsPerServing == this.carbsPerServing &&
          other.fatPerServing == this.fatPerServing &&
          other.ingredients == this.ingredients &&
          other.imageUrl == this.imageUrl &&
          other.category == this.category &&
          other.isPublic == this.isPublic &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> instructions;
  final Value<int?> prepTimeMinutes;
  final Value<int?> cookTimeMinutes;
  final Value<int?> servings;
  final Value<int?> caloriesPerServing;
  final Value<double?> proteinPerServing;
  final Value<double?> carbsPerServing;
  final Value<double?> fatPerServing;
  final Value<String> ingredients;
  final Value<String?> imageUrl;
  final Value<String?> category;
  final Value<bool> isPublic;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.instructions = const Value.absent(),
    this.prepTimeMinutes = const Value.absent(),
    this.cookTimeMinutes = const Value.absent(),
    this.servings = const Value.absent(),
    this.caloriesPerServing = const Value.absent(),
    this.proteinPerServing = const Value.absent(),
    this.carbsPerServing = const Value.absent(),
    this.fatPerServing = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.category = const Value.absent(),
    this.isPublic = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RecipesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String name,
    this.description = const Value.absent(),
    required String instructions,
    this.prepTimeMinutes = const Value.absent(),
    this.cookTimeMinutes = const Value.absent(),
    this.servings = const Value.absent(),
    this.caloriesPerServing = const Value.absent(),
    this.proteinPerServing = const Value.absent(),
    this.carbsPerServing = const Value.absent(),
    this.fatPerServing = const Value.absent(),
    required String ingredients,
    this.imageUrl = const Value.absent(),
    this.category = const Value.absent(),
    this.isPublic = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       name = Value(name),
       instructions = Value(instructions),
       ingredients = Value(ingredients),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Recipe> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? instructions,
    Expression<int>? prepTimeMinutes,
    Expression<int>? cookTimeMinutes,
    Expression<int>? servings,
    Expression<int>? caloriesPerServing,
    Expression<double>? proteinPerServing,
    Expression<double>? carbsPerServing,
    Expression<double>? fatPerServing,
    Expression<String>? ingredients,
    Expression<String>? imageUrl,
    Expression<String>? category,
    Expression<bool>? isPublic,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (instructions != null) 'instructions': instructions,
      if (prepTimeMinutes != null) 'prep_time_minutes': prepTimeMinutes,
      if (cookTimeMinutes != null) 'cook_time_minutes': cookTimeMinutes,
      if (servings != null) 'servings': servings,
      if (caloriesPerServing != null)
        'calories_per_serving': caloriesPerServing,
      if (proteinPerServing != null) 'protein_per_serving': proteinPerServing,
      if (carbsPerServing != null) 'carbs_per_serving': carbsPerServing,
      if (fatPerServing != null) 'fat_per_serving': fatPerServing,
      if (ingredients != null) 'ingredients': ingredients,
      if (imageUrl != null) 'image_url': imageUrl,
      if (category != null) 'category': category,
      if (isPublic != null) 'is_public': isPublic,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? instructions,
    Value<int?>? prepTimeMinutes,
    Value<int?>? cookTimeMinutes,
    Value<int?>? servings,
    Value<int?>? caloriesPerServing,
    Value<double?>? proteinPerServing,
    Value<double?>? carbsPerServing,
    Value<double?>? fatPerServing,
    Value<String>? ingredients,
    Value<String?>? imageUrl,
    Value<String?>? category,
    Value<bool>? isPublic,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      servings: servings ?? this.servings,
      caloriesPerServing: caloriesPerServing ?? this.caloriesPerServing,
      proteinPerServing: proteinPerServing ?? this.proteinPerServing,
      carbsPerServing: carbsPerServing ?? this.carbsPerServing,
      fatPerServing: fatPerServing ?? this.fatPerServing,
      ingredients: ingredients ?? this.ingredients,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (prepTimeMinutes.present) {
      map['prep_time_minutes'] = Variable<int>(prepTimeMinutes.value);
    }
    if (cookTimeMinutes.present) {
      map['cook_time_minutes'] = Variable<int>(cookTimeMinutes.value);
    }
    if (servings.present) {
      map['servings'] = Variable<int>(servings.value);
    }
    if (caloriesPerServing.present) {
      map['calories_per_serving'] = Variable<int>(caloriesPerServing.value);
    }
    if (proteinPerServing.present) {
      map['protein_per_serving'] = Variable<double>(proteinPerServing.value);
    }
    if (carbsPerServing.present) {
      map['carbs_per_serving'] = Variable<double>(carbsPerServing.value);
    }
    if (fatPerServing.present) {
      map['fat_per_serving'] = Variable<double>(fatPerServing.value);
    }
    if (ingredients.present) {
      map['ingredients'] = Variable<String>(ingredients.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isPublic.present) {
      map['is_public'] = Variable<bool>(isPublic.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('prepTimeMinutes: $prepTimeMinutes, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('servings: $servings, ')
          ..write('caloriesPerServing: $caloriesPerServing, ')
          ..write('proteinPerServing: $proteinPerServing, ')
          ..write('carbsPerServing: $carbsPerServing, ')
          ..write('fatPerServing: $fatPerServing, ')
          ..write('ingredients: $ingredients, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('category: $category, ')
          ..write('isPublic: $isPublic, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$RecipesDao extends GeneratedDatabase {
  _$RecipesDao(QueryExecutor e) : super(e);
  $RecipesDaoManager get managers => $RecipesDaoManager(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [recipes];
}

typedef $$RecipesTableCreateCompanionBuilder =
    RecipesCompanion Function({
      Value<int> id,
      required String userId,
      required String name,
      Value<String?> description,
      required String instructions,
      Value<int?> prepTimeMinutes,
      Value<int?> cookTimeMinutes,
      Value<int?> servings,
      Value<int?> caloriesPerServing,
      Value<double?> proteinPerServing,
      Value<double?> carbsPerServing,
      Value<double?> fatPerServing,
      required String ingredients,
      Value<String?> imageUrl,
      Value<String?> category,
      Value<bool> isPublic,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$RecipesTableUpdateCompanionBuilder =
    RecipesCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> name,
      Value<String?> description,
      Value<String> instructions,
      Value<int?> prepTimeMinutes,
      Value<int?> cookTimeMinutes,
      Value<int?> servings,
      Value<int?> caloriesPerServing,
      Value<double?> proteinPerServing,
      Value<double?> carbsPerServing,
      Value<double?> fatPerServing,
      Value<String> ingredients,
      Value<String?> imageUrl,
      Value<String?> category,
      Value<bool> isPublic,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$RecipesTableFilterComposer
    extends Composer<_$RecipesDao, $RecipesTable> {
  $$RecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPerServing => $composableBuilder(
    column: $table.proteinPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsPerServing => $composableBuilder(
    column: $table.carbsPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPerServing => $composableBuilder(
    column: $table.fatPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPublic => $composableBuilder(
    column: $table.isPublic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecipesTableOrderingComposer
    extends Composer<_$RecipesDao, $RecipesTable> {
  $$RecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPerServing => $composableBuilder(
    column: $table.proteinPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsPerServing => $composableBuilder(
    column: $table.carbsPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPerServing => $composableBuilder(
    column: $table.fatPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPublic => $composableBuilder(
    column: $table.isPublic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipesTableAnnotationComposer
    extends Composer<_$RecipesDao, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  GeneratedColumn<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPerServing => $composableBuilder(
    column: $table.proteinPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsPerServing => $composableBuilder(
    column: $table.carbsPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPerServing => $composableBuilder(
    column: $table.fatPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isPublic =>
      $composableBuilder(column: $table.isPublic, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$RecipesDao,
          $RecipesTable,
          Recipe,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (Recipe, BaseReferences<_$RecipesDao, $RecipesTable, Recipe>),
          Recipe,
          PrefetchHooks Function()
        > {
  $$RecipesTableTableManager(_$RecipesDao db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> instructions = const Value.absent(),
                Value<int?> prepTimeMinutes = const Value.absent(),
                Value<int?> cookTimeMinutes = const Value.absent(),
                Value<int?> servings = const Value.absent(),
                Value<int?> caloriesPerServing = const Value.absent(),
                Value<double?> proteinPerServing = const Value.absent(),
                Value<double?> carbsPerServing = const Value.absent(),
                Value<double?> fatPerServing = const Value.absent(),
                Value<String> ingredients = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<bool> isPublic = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RecipesCompanion(
                id: id,
                userId: userId,
                name: name,
                description: description,
                instructions: instructions,
                prepTimeMinutes: prepTimeMinutes,
                cookTimeMinutes: cookTimeMinutes,
                servings: servings,
                caloriesPerServing: caloriesPerServing,
                proteinPerServing: proteinPerServing,
                carbsPerServing: carbsPerServing,
                fatPerServing: fatPerServing,
                ingredients: ingredients,
                imageUrl: imageUrl,
                category: category,
                isPublic: isPublic,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String name,
                Value<String?> description = const Value.absent(),
                required String instructions,
                Value<int?> prepTimeMinutes = const Value.absent(),
                Value<int?> cookTimeMinutes = const Value.absent(),
                Value<int?> servings = const Value.absent(),
                Value<int?> caloriesPerServing = const Value.absent(),
                Value<double?> proteinPerServing = const Value.absent(),
                Value<double?> carbsPerServing = const Value.absent(),
                Value<double?> fatPerServing = const Value.absent(),
                required String ingredients,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<bool> isPublic = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => RecipesCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                description: description,
                instructions: instructions,
                prepTimeMinutes: prepTimeMinutes,
                cookTimeMinutes: cookTimeMinutes,
                servings: servings,
                caloriesPerServing: caloriesPerServing,
                proteinPerServing: proteinPerServing,
                carbsPerServing: carbsPerServing,
                fatPerServing: fatPerServing,
                ingredients: ingredients,
                imageUrl: imageUrl,
                category: category,
                isPublic: isPublic,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$RecipesDao,
      $RecipesTable,
      Recipe,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (Recipe, BaseReferences<_$RecipesDao, $RecipesTable, Recipe>),
      Recipe,
      PrefetchHooks Function()
    >;

class $RecipesDaoManager {
  final _$RecipesDao _db;
  $RecipesDaoManager(this._db);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
}
