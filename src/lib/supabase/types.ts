export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.1"
  }
  public: {
    Tables: {
      ai_conversations: {
        Row: {
          context_id: string | null
          context_type: string | null
          created_at: string | null
          id: string
          summary: string | null
          user_id: string | null
        }
        Insert: {
          context_id?: string | null
          context_type?: string | null
          created_at?: string | null
          id?: string
          summary?: string | null
          user_id?: string | null
        }
        Update: {
          context_id?: string | null
          context_type?: string | null
          created_at?: string | null
          id?: string
          summary?: string | null
          user_id?: string | null
        }
        Relationships: []
      }
      ai_messages: {
        Row: {
          content: string
          conversation_id: string | null
          created_at: string | null
          id: string
          metadata: Json | null
          role: string
        }
        Insert: {
          content: string
          conversation_id?: string | null
          created_at?: string | null
          id?: string
          metadata?: Json | null
          role: string
        }
        Update: {
          content?: string
          conversation_id?: string | null
          created_at?: string | null
          id?: string
          metadata?: Json | null
          role?: string
        }
        Relationships: [
          {
            foreignKeyName: "ai_messages_conversation_id_fkey"
            columns: ["conversation_id"]
            isOneToOne: false
            referencedRelation: "ai_conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      ai_usage: {
        Row: {
          date: string | null
          id: string
          input_tokens: number | null
          messages_count: number | null
          output_tokens: number | null
          user_id: string | null
        }
        Insert: {
          date?: string | null
          id?: string
          input_tokens?: number | null
          messages_count?: number | null
          output_tokens?: number | null
          user_id?: string | null
        }
        Update: {
          date?: string | null
          id?: string
          input_tokens?: number | null
          messages_count?: number | null
          output_tokens?: number | null
          user_id?: string | null
        }
        Relationships: []
      }
      character_profiles: {
        Row: {
          id: string
          user_id: string
          character_name: string
          valued_direction: string
          main_obstacle: string
          current_behavior: string | null
          context: string
          context_detail: string | null
          profile_summary: string | null
          created_at: string | null
          updated_at: string | null
        }
        Insert: {
          id?: string
          user_id: string
          character_name: string
          valued_direction: string
          main_obstacle: string
          current_behavior?: string | null
          context?: string
          context_detail?: string | null
          profile_summary?: string | null
          created_at?: string | null
          updated_at?: string | null
        }
        Update: {
          id?: string
          user_id?: string
          character_name?: string
          valued_direction?: string
          main_obstacle?: string
          current_behavior?: string | null
          context?: string
          context_detail?: string | null
          profile_summary?: string | null
          created_at?: string | null
          updated_at?: string | null
        }
        Relationships: []
      }
      blog_posts: {
        Row: {
          author_id: string | null
          content: string
          created_at: string | null
          excerpt: string | null
          id: string
          published_at: string | null
          slug: string
          status: string | null
          title: string
          updated_at: string | null
        }
        Insert: {
          author_id?: string | null
          content: string
          created_at?: string | null
          excerpt?: string | null
          id?: string
          published_at?: string | null
          slug: string
          status?: string | null
          title: string
          updated_at?: string | null
        }
        Update: {
          author_id?: string | null
          content?: string
          created_at?: string | null
          excerpt?: string | null
          id?: string
          published_at?: string | null
          slug?: string
          status?: string | null
          title?: string
          updated_at?: string | null
        }
        Relationships: []
      }
      lesson_progress: {
        Row: {
          ai_feedback: Json | null
          completed_at: string | null
          created_at: string | null
          id: string
          lesson_id: string | null
          responses: Json | null
          started_at: string | null
          status: string | null
          user_id: string | null
        }
        Insert: {
          ai_feedback?: Json | null
          completed_at?: string | null
          created_at?: string | null
          id?: string
          lesson_id?: string | null
          responses?: Json | null
          started_at?: string | null
          status?: string | null
          user_id?: string | null
        }
        Update: {
          ai_feedback?: Json | null
          completed_at?: string | null
          created_at?: string | null
          id?: string
          lesson_id?: string | null
          responses?: Json | null
          started_at?: string | null
          status?: string | null
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "lesson_progress_lesson_id_fkey"
            columns: ["lesson_id"]
            isOneToOne: false
            referencedRelation: "lessons"
            referencedColumns: ["id"]
          },
        ]
      }
      lessons: {
        Row: {
          content: Json | null
          created_at: string | null
          duration_seconds: number | null
          id: string
          lesson_type: string | null
          metadata: Json | null
          module_id: string | null
          order: number
          status: string | null
          title: string
          vimeo_video_id: string | null
        }
        Insert: {
          content?: Json | null
          created_at?: string | null
          duration_seconds?: number | null
          id?: string
          lesson_type?: string | null
          metadata?: Json | null
          module_id?: string | null
          order?: number
          status?: string | null
          title: string
          vimeo_video_id?: string | null
        }
        Update: {
          content?: Json | null
          created_at?: string | null
          duration_seconds?: number | null
          id?: string
          lesson_type?: string | null
          metadata?: Json | null
          module_id?: string | null
          order?: number
          status?: string | null
          title?: string
          vimeo_video_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "lessons_module_id_fkey"
            columns: ["module_id"]
            isOneToOne: false
            referencedRelation: "modules"
            referencedColumns: ["id"]
          },
        ]
      }
      module_progress: {
        Row: {
          completed_at: string | null
          created_at: string | null
          id: string
          lessons_completed: number | null
          lessons_total: number | null
          module_id: string | null
          user_id: string | null
        }
        Insert: {
          completed_at?: string | null
          created_at?: string | null
          id?: string
          lessons_completed?: number | null
          lessons_total?: number | null
          module_id?: string | null
          user_id?: string | null
        }
        Update: {
          completed_at?: string | null
          created_at?: string | null
          id?: string
          lessons_completed?: number | null
          lessons_total?: number | null
          module_id?: string | null
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "module_progress_module_id_fkey"
            columns: ["module_id"]
            isOneToOne: false
            referencedRelation: "modules"
            referencedColumns: ["id"]
          },
        ]
      }
      modules: {
        Row: {
          act_process: string | null
          color_theme: string | null
          created_at: string | null
          description: string | null
          estimated_duration_minutes: number | null
          icon: string | null
          id: string
          order: number
          program_id: string | null
          title: string
        }
        Insert: {
          act_process?: string | null
          color_theme?: string | null
          created_at?: string | null
          description?: string | null
          estimated_duration_minutes?: number | null
          icon?: string | null
          id?: string
          order?: number
          program_id?: string | null
          title: string
        }
        Update: {
          act_process?: string | null
          color_theme?: string | null
          created_at?: string | null
          description?: string | null
          estimated_duration_minutes?: number | null
          icon?: string | null
          id?: string
          order?: number
          program_id?: string | null
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "modules_program_id_fkey"
            columns: ["program_id"]
            isOneToOne: false
            referencedRelation: "programs"
            referencedColumns: ["id"]
          },
        ]
      }
      notification_preferences: {
        Row: {
          created_at: string | null
          id: string
          per_type_settings: Json | null
          preferred_channels: Json | null
          quiet_hours_end: string | null
          quiet_hours_start: string | null
          user_id: string | null
        }
        Insert: {
          created_at?: string | null
          id?: string
          per_type_settings?: Json | null
          preferred_channels?: Json | null
          quiet_hours_end?: string | null
          quiet_hours_start?: string | null
          user_id?: string | null
        }
        Update: {
          created_at?: string | null
          id?: string
          per_type_settings?: Json | null
          preferred_channels?: Json | null
          quiet_hours_end?: string | null
          quiet_hours_start?: string | null
          user_id?: string | null
        }
        Relationships: []
      }
      notifications: {
        Row: {
          channel: string
          content: Json
          created_at: string | null
          id: string
          scheduled_for: string | null
          sent_at: string | null
          status: string | null
          type: string
          user_id: string | null
        }
        Insert: {
          channel: string
          content: Json
          created_at?: string | null
          id?: string
          scheduled_for?: string | null
          sent_at?: string | null
          status?: string | null
          type: string
          user_id?: string | null
        }
        Update: {
          channel?: string
          content?: Json
          created_at?: string | null
          id?: string
          scheduled_for?: string | null
          sent_at?: string | null
          status?: string | null
          type?: string
          user_id?: string | null
        }
        Relationships: []
      }
      profiles: {
        Row: {
          age_bracket: string | null
          created_at: string | null
          display_name: string | null
          id: string
          notification_preferences: Json | null
          onboarding_completed: boolean | null
          phone_number: string | null
          preferred_language: string | null
          sport: string | null
          subscription_status: string | null
          subscription_tier: string | null
          training_schedule: Json | null
          updated_at: string | null
        }
        Insert: {
          age_bracket?: string | null
          created_at?: string | null
          display_name?: string | null
          id: string
          notification_preferences?: Json | null
          onboarding_completed?: boolean | null
          phone_number?: string | null
          preferred_language?: string | null
          sport?: string | null
          subscription_status?: string | null
          subscription_tier?: string | null
          training_schedule?: Json | null
          updated_at?: string | null
        }
        Update: {
          age_bracket?: string | null
          created_at?: string | null
          display_name?: string | null
          id?: string
          notification_preferences?: Json | null
          onboarding_completed?: boolean | null
          phone_number?: string | null
          preferred_language?: string | null
          sport?: string | null
          subscription_status?: string | null
          subscription_tier?: string | null
          training_schedule?: Json | null
          updated_at?: string | null
        }
        Relationships: []
      }
      programs: {
        Row: {
          created_at: string | null
          description: string | null
          id: string
          order: number
          title: string
        }
        Insert: {
          created_at?: string | null
          description?: string | null
          id?: string
          order?: number
          title: string
        }
        Update: {
          created_at?: string | null
          description?: string | null
          id?: string
          order?: number
          title?: string
        }
        Relationships: []
      }
      sms_queue: {
        Row: {
          created_at: string | null
          error_message: string | null
          id: string
          message: string
          module_number: number | null
          phone_number: string
          scheduled_for: string | null
          sent_at: string | null
          status: string | null
          trigger_type: string
          user_id: string | null
        }
        Insert: {
          created_at?: string | null
          error_message?: string | null
          id?: string
          message: string
          module_number?: number | null
          phone_number: string
          scheduled_for?: string | null
          sent_at?: string | null
          status?: string | null
          trigger_type: string
          user_id?: string | null
        }
        Update: {
          created_at?: string | null
          error_message?: string | null
          id?: string
          message?: string
          module_number?: number | null
          phone_number?: string
          scheduled_for?: string | null
          sent_at?: string | null
          status?: string | null
          trigger_type?: string
          user_id?: string | null
        }
        Relationships: []
      }
      toughness_model: {
        Row: {
          acceptance_score: number | null
          committed_action_score: number | null
          created_at: string | null
          defusion_score: number | null
          id: string
          present_moment_score: number | null
          self_as_context_score: number | null
          snapshot_date: string | null
          user_id: string | null
          values_score: number | null
        }
        Insert: {
          acceptance_score?: number | null
          committed_action_score?: number | null
          created_at?: string | null
          defusion_score?: number | null
          id?: string
          present_moment_score?: number | null
          self_as_context_score?: number | null
          snapshot_date?: string | null
          user_id?: string | null
          values_score?: number | null
        }
        Update: {
          acceptance_score?: number | null
          committed_action_score?: number | null
          created_at?: string | null
          defusion_score?: number | null
          id?: string
          present_moment_score?: number | null
          self_as_context_score?: number | null
          snapshot_date?: string | null
          user_id?: string | null
          values_score?: number | null
        }
        Relationships: []
      }
      toughness_model_data: {
        Row: {
          beteenden: Json | null
          created_at: string | null
          fokusrutiner: Json | null
          gameplan: Json | null
          hinder: Json | null
          id: string
          kartlaggning: Json | null
          updated_at: string | null
          user_id: string | null
          vaga_lista: Json | null
          varderad_riktning: Json | null
        }
        Insert: {
          beteenden?: Json | null
          created_at?: string | null
          fokusrutiner?: Json | null
          gameplan?: Json | null
          hinder?: Json | null
          id?: string
          kartlaggning?: Json | null
          updated_at?: string | null
          user_id?: string | null
          vaga_lista?: Json | null
          varderad_riktning?: Json | null
        }
        Update: {
          beteenden?: Json | null
          created_at?: string | null
          fokusrutiner?: Json | null
          gameplan?: Json | null
          hinder?: Json | null
          id?: string
          kartlaggning?: Json | null
          updated_at?: string | null
          user_id?: string | null
          vaga_lista?: Json | null
          varderad_riktning?: Json | null
        }
        Relationships: []
      }
      user_streaks: {
        Row: {
          current_streak: number | null
          id: string
          last_activity_date: string | null
          longest_streak: number | null
          streak_freezes_available: number | null
          streak_freezes_used: number | null
          updated_at: string | null
          user_id: string | null
        }
        Insert: {
          current_streak?: number | null
          id?: string
          last_activity_date?: string | null
          longest_streak?: number | null
          streak_freezes_available?: number | null
          streak_freezes_used?: number | null
          updated_at?: string | null
          user_id?: string | null
        }
        Update: {
          current_streak?: number | null
          id?: string
          last_activity_date?: string | null
          longest_streak?: number | null
          streak_freezes_available?: number | null
          streak_freezes_used?: number | null
          updated_at?: string | null
          user_id?: string | null
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      user_role: { Args: never; Returns: string }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const

// ─── Domain type aliases ──────────────────────────────────────────────────────
// These are not DB enums but are used throughout the codebase for type safety.

export type UserRole = "admin" | "athlete";

export type SubscriptionTier = "free" | "standard" | "premium";

export type SubscriptionStatus =
  | "active"
  | "trialing"
  | "past_due"
  | "canceled"
  | "incomplete"
  | "expired";

export type ActProcess =
  | "values"
  | "acceptance"
  | "defusion"
  | "present_moment"
  | "self_as_context"
  | "committed_action"
  | "integration";

export type ProgressStatus = "not_started" | "in_progress" | "completed";

export type LessonStatus = "draft" | "published" | "archived";

export type AiContextType = "general" | "lesson" | "module" | "progress";

export type NotificationChannel = "in_app" | "email" | "sms";
