class AnimeSearch
    def self.fuzzy_matching(query)
        # TODO: better than last(10), take into account the actual distance value maybe
        Anime.all.sort_by { |a| jaccard_similarity(a.name, query) }.last(10)
    end

    private

    # Maybe do better than max, something that take into account the sum or average... don't know yet
    def self.anime_jaccard_similarity(anime, query)
        
    end

    # Compute the jaccard distance between s1 and s2
    # Issue is that "hunter hunter" is as close from "Hunter x Hunter" than "City Hunter"
    def self.jaccard_similarity(s1, s2)
        # class constant ?
        n = 3

        # I think we don't care about case
        s1_n_grams = character_n_grams(s1.downcase, n).to_set
        s2_n_grams = character_n_grams(s2.downcase, n).to_set

        intersection = s1_n_grams & s2_n_grams
        union = s1_n_grams | s2_n_grams

        intersection.length / union.length.to_f
    end

    def self.character_n_grams(s, n)
        s.split('').each_cons(n).map{ |n_characters_list| n_characters_list.join('') }
    end
end