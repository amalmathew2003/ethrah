import '../models/models.dart';  // ✅ CORRECTED IMPORT PATH

class DummyData {
  // Ethnic Wear Products
  static final Product ethnicSaree = Product(
    id: '1',
    name: 'Handwoven Silk Saree',
    description: 'Exquisite handwoven saree crafted with pure silk and traditional motifs.',
    imageUrl: 'https://images.unsplash.com/photo-1629355889906-a1e6c86a9a90?w=500&q=80',
    category: 'ethnic',
    price: '₹12,500',
    material: '100% Pure Silk, Traditional Handweaving',
    careInstructions: 'Dry clean only. Store in a cool, dry place away from direct sunlight.',
    galleryImages: [
      'https://images.unsplash.com/photo-1629355889906-a1e6c86a9a90?w=800&q=80',
      'https://images.unsplash.com/photo-1583391733519-3346a1be7dee?w=800&q=80',
      'https://images.unsplash.com/photo-1582142407350-2a4e2d0e8f4b?w=800&q=80',
    ],
  );

  static final Product ethnicLehenga = Product(
    id: '2',
    name: 'Embroidered Lehenga',
    description: 'Stunning lehenga with intricate embroidery and mirror work. Perfect for festive occasions.',
    imageUrl: 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=500&q=80',
    category: 'ethnic',
    price: '₹18,000',
    material: 'Georgette, Silk, Mirror Work Embroidery',
    careInstructions: 'Professional dry cleaning recommended. Handle embroidery with care.',
    galleryImages: [
      'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=800&q=80',
      'https://images.unsplash.com/photo-1585399592865-30fa38196e1a?w=800&q=80',
      'https://images.unsplash.com/photo-1520591516675-52658b46e625?w=800&q=80',
    ],
  );

  static final Product ethnicKurti = Product(
    id: '3',
    name: 'Contemporary Ethnic Kurti',
    description: 'Modern kurti blending traditional patterns with contemporary silhouette.',
    imageUrl: 'https://images.unsplash.com/photo-1610701596007-11502861dcfa?w=500&q=80',
    category: 'ethnic',
    price: '₹8,500',
    material: 'Cotton Blend, Block Print',
    careInstructions: 'Machine wash in cold water. Air dry to maintain color vibrancy.',
    galleryImages: [
      'https://images.unsplash.com/photo-1610701596007-11502861dcfa?w=800&q=80',
      'https://images.unsplash.com/photo-1617197135910-4f952e2c99fa?w=800&q=80',
      'https://images.unsplash.com/photo-1585399592865-30fa38196e1a?w=800&q=80',
    ],
  );

  static final Product contemporarySalwar = Product(
    id: '4',
    name: 'Minimalist Salwar Suit',
    description: 'Clean lines and elegant draping define this modern salwar suit collection.',
    imageUrl: 'https://images.unsplash.com/photo-1617197135910-4f952e2c99fa?w=500&q=80',
    category: 'contemporary',
    price: '₹9,500',
    material: 'Premium Cotton, Minimal Print',
    careInstructions: 'Hand wash or gentle machine wash. Dry flat to prevent shrinking.',
    galleryImages: [
      'https://images.unsplash.com/photo-1617197135910-4f952e2c99fa?w=800&q=80',
      'https://images.unsplash.com/photo-1610701596007-11502861dcfa?w=800&q=80',
      'https://images.unsplash.com/photo-1620012253295-c15cc7cb4c08?w=800&q=80',
    ],
  );

  static final Product contemporaryAnarkali = Product(
    id: '5',
    name: 'Fusion Anarkali',
    description: 'Blend of traditional anarkali with modern aesthetics and minimalist design.',
    imageUrl: 'https://images.unsplash.com/photo-1585399592865-30fa38196e1a?w=500&q=80',
    category: 'contemporary',
    price: '₹11,000',
    material: 'Silk Blend, Subtle Embroidery',
    careInstructions: 'Dry clean recommended for longevity. Store on padded hangers.',
    galleryImages: [
      'https://images.unsplash.com/photo-1585399592865-30fa38196e1a?w=800&q=80',
      'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=800&q=80',
      'https://images.unsplash.com/photo-1617197135910-4f952e2c99fa?w=800&q=80',
    ],
  );

  static final Product jewellerySets = Product(
    id: '6',
    name: 'Statement Necklace Set',
    description: 'Handcrafted jewelry set featuring traditional motifs with contemporary design.',
    imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500&q=80',
    category: 'jewellery',
    price: '₹6,500',
    material: '22K Gold Plated, Semi-precious Stones',
    careInstructions: 'Store in a dry place. Avoid contact with perfumes and cosmetics. Clean with soft cloth.',
    galleryImages: [
      'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=800&q=80',
      'https://images.unsplash.com/photo-1515562141207-5daa5b88b57c?w=800&q=80',
      'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=800&q=80',
    ],
  );

  static final Product jewelleryChandbali = Product(
    id: '7',
    name: 'Chandbali Earrings',
    description: 'Traditional chandbali earrings with pearls and gemstones in modern design.',
    imageUrl: 'https://images.unsplash.com/photo-1515562141207-5daa5b88b57c?w=500&q=80',
    category: 'jewellery',
    price: '₹5,500',
    material: '18K Gold Plated, Natural Pearls',
    careInstructions: 'Handle with care. Keep away from moisture. Polish gently with provided cloth.',
    galleryImages: [
      'https://images.unsplash.com/photo-1515562141207-5daa5b88b57c?w=800&q=80',
      'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=800&q=80',
      'https://images.unsplash.com/photo-1515562141207-5daa5b88b57c?w=800&q=80',
    ],
  );

  static final Product jewelleriBangles = Product(
    id: '8',
    name: 'Bangle Set',
    description: 'Exquisite bangle set combining traditional craftsmanship with elegance.',
    imageUrl: 'https://images.unsplash.com/photo-1625458534895-fcf21eab32be?w=500&q=80',
    category: 'jewellery',
    price: '₹4,500',
    material: '22K Gold Plated Brass, Gemstones',
    careInstructions: 'Remove before bathing. Store separately to avoid scratching. Avoid harsh chemicals.',
    galleryImages: [
      'https://images.unsplash.com/photo-1625458534895-fcf21eab32be?w=800&q=80',
      'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=800&q=80',
      'https://images.unsplash.com/photo-1515562141207-5daa5b88b57c?w=800&q=80',
    ],
  );

  static final Collection ethnicCollection = Collection(
    id: 'ethnic',
    name: 'Ethnic Wear',
    description: 'Celebrate tradition with our premium ethnic collection featuring handwoven sarees, embroidered lehengas, and traditional wear.',
    coverImage: 'https://images.unsplash.com/photo-1629355889906-a1e6c86a9a90?w=800&q=80',
    products: [ethnicSaree, ethnicLehenga, ethnicKurti],
  );

  static final Collection contemporaryCollection = Collection(
    id: 'contemporary',
    name: 'Contemporary Wear',
    description: 'Modern silhouettes with ethnic elements. Perfect for the contemporary woman who values tradition.',
    coverImage: 'https://images.unsplash.com/photo-1617197135910-4f952e2c99fa?w=800&q=80',
    products: [contemporarySalwar, contemporaryAnarkali],
  );

  static final Collection jewelleryCollection = Collection(
    id: 'jewellery',
    name: 'Jewellery Collection',
    description: 'Handcrafted jewelry pieces that add elegance to every occasion. Each piece tells a story.',
    coverImage: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=800&q=80',
    products: [jewellerySets, jewelleryChandbali, jewelleriBangles],
  );

  static final List<Collection> allCollections = [
    ethnicCollection,
    contemporaryCollection,
    jewelleryCollection,
  ];

  static final List<GalleryItem> galleryItems = [
    GalleryItem(
      id: '1',
      imageUrl: 'https://images.unsplash.com/photo-1629355889906-a1e6c86a9a90?w=500&q=80',
      title: 'Handwoven Collection',
      category: 'Ethnic',
    ),
    GalleryItem(
      id: '2',
      imageUrl: 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=500&q=80',
      title: 'Embroidered Lehenga',
      category: 'Ethnic',
    ),
    GalleryItem(
      id: '3',
      imageUrl: 'https://images.unsplash.com/photo-1617197135910-4f952e2c99fa?w=500&q=80',
      title: 'Contemporary Fusion',
      category: 'Contemporary',
    ),
    GalleryItem(
      id: '4',
      imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500&q=80',
      title: 'Statement Jewelry',
      category: 'Jewelry',
    ),
    GalleryItem(
      id: '5',
      imageUrl: 'https://images.unsplash.com/photo-1515562141207-5daa5b88b57c?w=500&q=80',
      title: 'Traditional Elegance',
      category: 'Jewelry',
    ),
    GalleryItem(
      id: '6',
      imageUrl: 'https://images.unsplash.com/photo-1610701596007-11502861dcfa?w=500&q=80',
      title: 'Ethnic Kurti',
      category: 'Ethnic',
    ),
    GalleryItem(
      id: '7',
      imageUrl: 'https://images.unsplash.com/photo-1585399592865-30fa38196e1a?w=500&q=80',
      title: 'Fusion Anarkali',
      category: 'Contemporary',
    ),
    GalleryItem(
      id: '8',
      imageUrl: 'https://images.unsplash.com/photo-1625458534895-fcf21eab32be?w=500&q=80',
      title: 'Bangle Collection',
      category: 'Jewelry',
    ),
  ];

  static final BrandInfo brandInfo = BrandInfo(
    name: 'Ethrah',
    tagline: 'Where Elegance Meets Tradition',
    story: 'Ethrah was born from a passion for celebrating the beauty of Indian heritage through contemporary design. Founded in 2020, we believe that traditional craftsmanship deserves to be cherished in the modern world. Each piece in our collection is a testament to the skilled artisans who dedicate their craft to creating timeless pieces.',
    mission: 'To create exquisite ethnic and contemporary wear that empowers women to express their cultural identity with pride and elegance.',
    vision: 'To become the go-to destination for women seeking premium, ethically-crafted ethnic wear and jewelry that transcends generations.',
    founderNote: 'Our journey began with a simple belief: that beauty, tradition, and modernity can coexist harmoniously. Every design in Ethrah is meticulously curated to reflect this philosophy. We work directly with artisans, ensuring fair practices and sustainable production. Your choice to wear Ethrah is a choice to celebrate art, craft, and the beauty of our cultural heritage.',
    founderName: 'Aisha Mehta',
    instagramHandle: 'ethrah.in',
    whatsappNumber: '+91 98765 43210',
    email: 'hello@ethrah.in',
  );
}
