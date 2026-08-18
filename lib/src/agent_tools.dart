import 'types.dart';

class AgentToolDefinition {
  const AgentToolDefinition(
      {required this.name,
      required this.description,
      required this.inputSchema,
      this.readOnly = true,
      this.requiresAuthentication = false});

  final String name;
  final String description;
  final JsonMap inputSchema;
  final bool readOnly;
  final bool requiresAuthentication;

  JsonMap toJson() => {
        'name': name,
        'description': description,
        'readOnly': readOnly,
        'requiresAuthentication': requiresAuthentication,
        'inputSchema': inputSchema,
      };
}

class EcommerceAgentTools {
  const EcommerceAgentTools._();

  static const List<AgentToolDefinition> safe = [
    AgentToolDefinition(
      name: 'catalog_list_products',
      description:
          'Search and paginate the public product catalog using exact catalog query fields.',
      inputSchema: {
        'type': 'object',
        'properties': {
          'locale': {
            'type': 'string',
            'enum': ['en', 'ar']
          },
          'category': {'type': 'string'},
          'brand': {'type': 'string'},
          'minPrice': {'type': 'number', 'minimum': 0},
          'maxPrice': {'type': 'number', 'minimum': 0},
          'inStockOnly': {'type': 'boolean'},
          'search': {'type': 'string'},
          'sort': {'type': 'string'},
          'page': {'type': 'integer', 'minimum': 1},
          'limit': {'type': 'integer', 'minimum': 1, 'maximum': 100},
        },
        'additionalProperties': false,
      },
    ),
    AgentToolDefinition(
      name: 'catalog_get_product',
      description: 'Get one public product by ID or slug.',
      inputSchema: {
        'type': 'object',
        'properties': {
          'idOrSlug': {'type': 'string', 'minLength': 1},
          'locale': {
            'type': 'string',
            'enum': ['en', 'ar']
          },
        },
        'required': ['idOrSlug'],
        'additionalProperties': false,
      },
    ),
    AgentToolDefinition(
      name: 'catalog_list_categories',
      description: 'List public product categories.',
      inputSchema: {
        'type': 'object',
        'properties': {
          'locale': {
            'type': 'string',
            'enum': ['en', 'ar']
          }
        },
        'additionalProperties': false,
      },
    ),
    AgentToolDefinition(
      name: 'catalog_list_brands',
      description: 'List public product brands.',
      inputSchema: {
        'type': 'object',
        'properties': {
          'locale': {
            'type': 'string',
            'enum': ['en', 'ar']
          }
        },
        'additionalProperties': false,
      },
    ),
    AgentToolDefinition(
      name: 'shipping_list_countries',
      description: 'List supported storefront shipping countries.',
      inputSchema: {
        'type': 'object',
        'properties': {},
        'additionalProperties': false
      },
    ),
    AgentToolDefinition(
      name: 'shipping_list_governorates',
      description: 'List governorates for a supported country code.',
      inputSchema: {
        'type': 'object',
        'properties': {
          'country': {'type': 'string', 'minLength': 2, 'maxLength': 2}
        },
        'required': ['country'],
        'additionalProperties': false,
      },
    ),
    AgentToolDefinition(
      name: 'checkout_quote',
      description:
          'Calculate a non-mutating checkout quote for one to one hundred product items.',
      inputSchema: {
        'type': 'object',
        'properties': {
          'items': {
            'type': 'array',
            'minItems': 1,
            'maxItems': 100,
            'items': {
              'type': 'object',
              'properties': {
                'productId': {'type': 'string', 'minLength': 1},
                'variantId': {'type': 'string', 'minLength': 1},
                'quantity': {'type': 'integer', 'minimum': 1, 'maximum': 100},
              },
              'required': ['productId', 'quantity'],
              'additionalProperties': false,
            },
          },
          'couponCode': {'type': 'string'},
          'shippingAddress': {'type': 'object'},
          'shippingMethodId': {'type': 'string'},
          'commerceContext': {'type': 'object'},
        },
        'required': ['items'],
        'additionalProperties': false,
      },
    ),
    AgentToolDefinition(
      name: 'cart_get',
      description:
          'Read the current authenticated or guest cart without changing it.',
      inputSchema: {
        'type': 'object',
        'properties': {},
        'additionalProperties': false
      },
      requiresAuthentication: false,
    ),
    AgentToolDefinition(
      name: 'account_get_profile',
      description: 'Read the authenticated account profile.',
      inputSchema: {
        'type': 'object',
        'properties': {},
        'additionalProperties': false
      },
      requiresAuthentication: true,
    ),
  ];

  static List<JsonMap> toJson() => safe.map((tool) => tool.toJson()).toList();
}
